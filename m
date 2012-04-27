Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:54323 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350Ab2D0OKo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2012 10:10:44 -0400
Received: by dadz8 with SMTP id z8so1069994dad.10
        for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 07:10:43 -0700 (PDT)
Message-ID: <4F9AA8DA.3050907@gmail.com>
Date: Fri, 27 Apr 2012 22:10:34 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Richard Yang <weiyang@linux.vnet.ibm.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: Does my understanding correct?
References: <20120427092704.GA22529@richard>
In-Reply-To: <20120427092704.GA22529@richard>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For PCI, there's no internal bus Bus#4 in the left bottom device.

On 04/27/2012 05:27 PM, Richard Yang wrote:
> All, 
> 
> I draw a picture about the physical layout on a part of the pci system.
> 
> Each block represent a bridge or a device.
> Am I correct?
>    
>     +-----------------------------+
>     |                             |
>     |                             |
>     |      Bus#2                  |
>     |   ------------------        |
>     |                             |
>     |                             |
>     |                             |
>     |               +-------------+
>     |               |DownStream   |02:00.0 pci_dev
>     +---------------+-------+-----+
>                             |   Bus#3
>              ---------------+------------------------------------------+---
>                             |                                          |
>                             |                                          |
>     +---------------+-------+-----+               +---------------+----+--+-----+
>     |               |UpStream     |03:00.0        |               |UpStream     |03:01.0
>     |               +-------------+               |               +-------------+ a normal device
>     |                             |               |                             |
>     |                             |               |                             |
>     |             Bus#4           |               |                             |
>     |     -------------------     |               |                             |
>     |                  +----------+               |                             |
>     |                  |DownStream|               |                             | 
>     +-----------------------+-----+               +-----------------------------+                       
>                             |                                                 
>                             | Bus#5                               
>                 ------------+------------                                                               
> 
> 

