Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:42881 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab3LHCsq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 21:48:46 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so2406909obc.30
        for <linux-pci@vger.kernel.org>; Sat, 07 Dec 2013 18:48:45 -0800 (PST)
Received: from [10.0.0.5] (pool-71-164-229-51.dllstx.fios.verizon.net. [71.164.229.51])
        by mx.google.com with ESMTPSA id n3sm2899064oep.2.2013.12.07.18.48.44
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Dec 2013 18:48:45 -0800 (PST)
Message-ID: <52A3DE0B.7020809@servergy.com>
Date: Sat, 07 Dec 2013 20:48:43 -0600
From: Ruchika <ruchika.k@servergy.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Question: 2 PCIE controllers
References: <52A26913.6030604@servergy.com>
In-Reply-To: <52A26913.6030604@servergy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi,
I am working with an Soc with 3 PCIE controllers.
I need to have 2 configured.

In uboot I have no problems scanning and discovering what is connected
to both bridges PCIE1 and PCIE2

For both uboot sets up the Primary, secondary and Subordinate bus
numbers to 0,1,1 respectively.

When linux boots up and probes the controllers, PCIE1 is probed and the
bridge scanned properly but PCIE2 is probed at the bridge but not
attempted a scan.
I see this message
"pci 0001:02:00.0: bridge configuration invalid ([bus 01-01]), reconfiguring
"

I updated uboot to set the secondary and subordinate numbers to 2 (left
the primary number to 0) and a subsequent kernel boot scanned the bus
for PCIE2 successfully.
I found these numbers to be very critical since the device tree blob
(bus-range) for pci is also based off these.

I'd like to get a good fix and get better understanding of the problem.
If there are any pointers someone could provide it would be awesome.

Thank you
Regards
Ruchika



