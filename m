Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 7 May 2018 08:16:27 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <keith.busch@linux.intel.com>
Subject: Re: PCIe unsupported request with Intel 760p
Message-ID: <20180507151627.GA1401@bombadil.infradead.org>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
 <20180507134354.GF18116@bombadil.infradead.org>
 <20180507151246.GB20686@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20180507151246.GB20686@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Aron Griffis <aron@arongriffis.com>, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 07, 2018 at 09:12:47AM -0600, Keith Busch wrote:
> Hi Willy,
> 
> Thank you for the detailed analysis. :)

You're welcome!  Here's the program I wrote to decode the TLP.  It's not
exactly fleshed out, but it could be used as the basis for a more
fully-featured TLP decoder in the future.

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

static void decode_requester(unsigned char *header)
{
	printf("Requester ID %02x:%02x.%d\n", header[4], header[5] >> 3,
			header[5] & 7);
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

	decode_requester(header);
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

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
