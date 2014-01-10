Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62204 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbaAJAqq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2014 19:46:46 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so4477696iec.33
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2014 16:46:46 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 9 Jan 2014 16:46:45 -0800
Message-ID: <CAE9FiQUGpBTijNGX6T=mLgoVa7wVegOMye8uGOqhKq93-1hyqQ@mail.gmail.com>
Subject: about mpss with pcie_bus_perf
From: Yinghai Lu <yinghai@kernel.org>
To: Myron Stowe <mstowe@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

looks like we have some problem with MPSS.

+-02.2-[10-1f]----00.0-[11-13]--+-02.0-[12]--+-00.0
                           |                      |                   \-00.1
                           |                      \-03.0-[13]----00.0

kernel boot with pce_bus_perf:
00:02.2: cap/ctl: 256/256
10:00.0: cap/ctl: 256/256
11:02.0: cap/ctl: 256/256
12:00.0: cap/ctl: 128/128
12:00.1: cap/ctl: 128/128

11:03.0: cap/ctl: 256/256
13:00.0: cap/ctl: 256/256

Should we set MPSS to 128?

Thanks

Yinghai
