Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeEFMDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 May 2018 08:03:40 -0400
Date: Sun, 6 May 2018 05:03:39 -0700
From: Matthew Wilcox <willy@infradead.org>
To: linux-pci@vger.kernel.org
Cc: Martin Mares <mj@ucw.cz>
Subject: decode-tlp.c
Message-ID: <20180506120339.GA7362@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A friend recently had his kernel spit out a message:

pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: id=00e8
pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=00e8(Requester ID)
pcieport 0000:00:1d.0:   device [8086:a298] error status/mask=00100000/00010000
pcieport 0000:00:1d.0:    [20] Unsupported Request    (First)
pcieport 0000:00:1d.0:   TLP Header: 34000000 70000010 00000000 88468846
pcieport 0000:00:1d.0: broadcast error_detected message
pcieport 0000:00:1d.0: broadcast mmio_enabled message
pcieport 0000:00:1d.0: broadcast resume message
pcieport 0000:00:1d.0: AER: Device recovery successful

and that wasn't really quite enough information to go on.  I decoded
this TLP by hand into a Latency Tolerance Reporting message, but this
is really something we should have a program for.

This solves my immediate needs; I'm sure it can be extended to be more
useful for other people.  Martin, do you want to include it in pciutils?


/*
 * Decode TLPs as reported by Linux's AER support
 *
 * Copyright (c) Matthew Wilcox 2018
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * The format of the report looks like this:
 *
 * TLP Header: 34000000 70000010 00000000 88468846
 *
 * That's a stream of bytes, *not* 32-bit words.  In that example, the
 * byte 0x34 is byte 0, not byte 3.
 */

#define _GNU_SOURCE

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

bool debug = false;

static int parse_header(unsigned char *header)
{
	char s[256];
	char *p;
	int i;

	p = fgets(s, 256, stdin);
	if (p)
		p = strstr(p, "TLP Header: ");
	if (!p) {
		fprintf(stderr, "Can\'t find \"TLP Header: \"\n");
		return 1;
	}

	p += 12;

	for (i = 0; i < 4; i++) {
		unsigned long val = strtoul(p, NULL, 16);
		header[0] = val >> 24;
		header[1] = val >> 16;
		header[2] = val >> 8;
		header[3] = val;
		p += 9;
		header += 4;
	}

	return 0;
}

static void decode_msg(unsigned char *header)
{
	unsigned char code = header[7];

	if (code == 0x00)
		printf("Unlock Message\n");
	if (code == 0x10)
		printf("Latency Tolerance Reporting Message\n");
	if (code == 0x12)
		printf("Optimised Buffer Flush/Fill Message\n");
	if (code == 0x14)
		printf("PM NAK Message\n");
	if (code == 0x18)
		printf("PM PME Message\n");
	if (code == 0x19)
		printf("PM Turn Off Message\n");
	if (code == 0x1b)
		printf("PM Ack Turn Off Message\n");
	if (code >= 0x20 && code <= 0x27)
		printf("Legacy Interrupt Message (%d)\n", code & 7);
	if (code == 0x30)
		printf("Error Detected (Correctable) Message\n");
	if (code == 0x31)
		printf("Error Detected (NonFatal) Message\n");
	if (code == 0x33)
		printf("Error Detected (Fatal) Message\n");
	if (code >= 0x40 && code <= 0x48)
		printf("Hotplug Signalling Message\n");
	if (code == 0x7e || code == 0x7f)
		printf("Vendor Defined (Type %d) Message\n", code - 0x7e);
	if (code == 0x90)
		printf("Set Slot Power Limit Message\n");
}

static void decode_type(unsigned char *header)
{
	unsigned char type = *header;

	if (type == 0x00 || type == 0x20)
		printf("Memory Read Request\n");
	if (type == 0x01 || type == 0x21)
		printf("Memory Read Request Locked\n");
	if (type == 0x40 || type == 0x60)
		printf("Memory Write Request\n");
	if (type == 0x02)
		printf("I/O Read Request\n");
	if (type == 0x42)
		printf("I/O Write Request\n");
	if (type == 0x04)
		printf("Cfg0 Read Request\n");
	if (type == 0x44)
		printf("Cfg0 Write Request\n");
	if (type == 0x05)
		printf("Cfg1 Read Request\n");
	if (type == 0x45)
		printf("Cfg1 Write Request\n");
	if (type == 0x1b)
		printf("TCfg Read Request\n");
	if (type == 0x5b)
		printf("TCfg Write Request\n");
	if (type >= 0x30 && type <= 0x37)
		return decode_msg(header);
	if (type >= 0x70 && type <= 0x77)
		printf("Msg with Data Request\n");
	if (type == 0x0a)
		printf("Completion\n");
	if (type == 0x4a)
		printf("Completion with Data\n");
	if (type == 0x0b)
		printf("Completion of Locked Read without Data\n");
	if (type == 0x4b)
		printf("Completion of Locked Read with Data\n");
	if (type == 0x4c || type == 0x6c)
		printf("FetchAdd Request\n");
	if (type == 0x4d || type == 0x6d)
		printf("Swap Request\n");
	if (type == 0x4e || type == 0x6e)
		printf("CAS Request\n");
	if (type >= 0x80 && type <= 0x8f) {
		printf("Local TLP Prefix %d\n", type & 0xf);
		return decode_type(header + 1);
	}
	if (type >= 0x90 && type <= 0x9f) {
		printf("End-End TLP Prefix %d\n", type & 0xf);
		return decode_type(header + 1);
	}
}

static int usage(char **argv)
{
	fprintf(stderr, "Usage: %s [-d]\n", argv[0]);
	return 1;
}

int main(int argc, char **argv)
{
	unsigned char header[16];
	int opt;

	while ((opt = getopt(argc, argv, "d")) != -1) {
		switch (opt) {
		case 'd':
			debug = true;
			break;
		default:
			return usage(argv);
		}
	}

	if (argc > optind)
		return usage(argv);

	if (parse_header(header))
		return 1;

	if (debug)
		printf("TLP Header: %02x%02x%02x%02x %02x%02x%02x%02x "
			"%02x%02x%02x%02x %02x%02x%02x%02x\n",
			header[0], header[1], header[2], header[3],
			header[4], header[5], header[6], header[7],
			header[8], header[9], header[10], header[11],
			header[12], header[13], header[14], header[15]);

	decode_type(header);

	return 0;
}
