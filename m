Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36051 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759042Ab3LGAUh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2013 19:20:37 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so2612914iej.14
        for <linux-pci@vger.kernel.org>; Fri, 06 Dec 2013 16:20:36 -0800 (PST)
Received: from [10.0.0.5] (pool-71-164-229-51.dllstx.fios.verizon.net. [71.164.229.51])
        by mx.google.com with ESMTPSA id hv5sm461044igb.9.2013.12.06.16.20.34
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 16:20:34 -0800 (PST)
Message-ID: <52A269D0.2020303@servergy.com>
Date: Fri, 06 Dec 2013 18:20:32 -0600
From: Ruchika <ruchika.k@servergy.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: questions: second of the 2 pcie controllers does not scan the bus.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
I am working with an Soc with multiple PCIE controllers.
I need to have 2 configured properly.

In uboot I have no problems scanning and discovering what is connected 
to both controllers/PCI bridges.
PCIE1 :
PCIE2:

For both PCIE1/2 uboot sets up the Primary, secondary and Subordinate 
bus numbers to 0,1,1 respectively.

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

-- 
Regards,
Ruchika Kharwar | Validation engineer
Servergy, Inc. | Save Energy. Work Smart. ®
M (832) 276 9309| E ruchika.k@servergy.com
www.servergy.com
