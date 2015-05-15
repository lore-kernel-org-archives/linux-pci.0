Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0113.outbound.protection.outlook.com ([157.56.111.113]:4283
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755038AbbEOSB2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 May 2015 14:01:28 -0400
Date: Fri, 15 May 2015 10:28:37 -0700
From: Guenter Roeck <groeck@juniper.net>
To: <linux-pci@vger.kernel.org>
Subject: BAR 7 io space assignment errors
Message-ID: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

ever since 3.18(ish), we see lots of pcie io range allocation error messages
when booting our systems.

pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]

This is repeated for each port.

What we atually _want_ is no IO address range, but so far I have not been able to
tell this to the code (or to the bridge).

The IO space "0x1000-0xfff" gives an indication of what is going on, at least
to some degree. The io range is calculated in pbus_size_io() as
	b_res->start = min_align;
	b_res->end = b_res->start + size0 - 1;
with size0 == 0, so end < start.

Searching for the get_res_add_size and the BAR7 message suggests that many
others see the problem as well, so it appears that we are not alone.
I have not been able to find a solution, though.

Any idea what we may have to do to fix the problem, or in other words
what may be wrong ?

Thanks,
Guenter
