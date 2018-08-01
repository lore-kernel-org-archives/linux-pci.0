Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:53626 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388988AbeHATdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 15:33:50 -0400
Subject: Re: Possible race condition in the kernel between PCI driver and AER
 handling
To: gokul cg <gokuljnpr@gmail.com>
Cc: linux-pci@vger.kernel.org
References: <CAFP4jM9xmXHVnBPObNxTtr1kDo2kbW9G4N5q=BLU5gf5=+M0xg@mail.gmail.com>
 <c5fb4a6a-136f-99f1-104e-32c923f00a22@oracle.com>
 <CAFP4jM84BuVZ+yKvcVvbu_6LFoO+2iVivWWZTZgbEEy3=oMftg@mail.gmail.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <ecb55fb1-c3af-4f5b-86d2-1c669fa9f9ca@oracle.com>
Date: Wed, 1 Aug 2018 13:47:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAFP4jM84BuVZ+yKvcVvbu_6LFoO+2iVivWWZTZgbEEy3=oMftg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 08/01/2018 01:42 AM, gokul cg wrote:
> Hi Thomas,
> 
> In my hardware, there is i2c power control chip for PCI card, I just 
> powered down using i2c command .

Hi Gokul,
When you power off the card via the i2c, it forcefully power off the 
card without notify the kernel? That is, during the card power off 
sequence it manages to send a last AER isr to report the error and die? 
I am kind of expect the pcie surprise removal or hot plug driver will 
handle it correctly.

Thanks,
Thomas

> 
> Regards,
> Gokul
