Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:48649 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaCZLu1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 07:50:27 -0400
Received: by mail-wi0-f195.google.com with SMTP id bs8so496211wib.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2014 04:50:26 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 26 Mar 2014 17:20:26 +0530
Message-ID: <CANwwZzXdFsZGcjwOZURNG4=NPj0ZZ20e7euecGjgv==g=pBusQ@mail.gmail.com>
Subject: query regarding BAR mapping
From: Bob Biloxi <iambobbiloxi@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I am writing a driver for PCIe network device. I am still trying to
learn, so my question might be like a simple one as I do not
understand most of the things.

>From the BAR0 address that I read, the memory size is around 256MB.
But I have only 128MB at my disposal.

So my question is how do i map this BAR so as to access the MMIO region.

Thanks so much for your help.



Regards,
Marc Spencer
