Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:44223 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab1LFUfs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2011 15:35:48 -0500
Message-ID: <4EDE7A88.7080304@hp.com>
Date: Tue, 06 Dec 2011 14:26:48 -0600
From: Mike Miller <mike.miller@hp.com>
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/1] pciutils: add 8TB/s to link capabilities
References: <20111206191605.GA11235@beardog.cce.hp.com> <mj+md-20111206.195256.30852.nikam@ucw.cz>
In-Reply-To: <mj+md-20111206.195256.30852.nikam@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/06/2011 01:53 PM, Martin Mares wrote:
> Hello!
>
>> Right now lspci shows "Speed unknown" for PCIe Gen3 links. This two liner
>> adds 8GT/s to fix that. I don't think the next link rate has yet been
>> decided. So I only go to Gen3.
>
> I already have this one in my current Git tree (also available on kernel.org).
> It seems I really should push out a new release :-)
>
> 		Thanks anyway
> 					Martin
Thank you.

-- mikem
