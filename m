Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12360 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbcEQFxI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 01:53:08 -0400
Message-ID: <573AB1BE.6070809@intel.com>
Date: Tue, 17 May 2016 13:53:02 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] lspci: Decode Precision Time Measurement capabiltity
References: <1462850155-13790-1-git-send-email-jonathan.yong@intel.com> <1462850155-13790-2-git-send-email-jonathan.yong@intel.com> <mj+md-20160514.092404.57632.camelot@ucw.cz>
In-Reply-To: <mj+md-20160514.092404.57632.camelot@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/14/2016 17:24, Martin Mares wrote:
> Hello!
>
>> Section 7.32 Precision Time Management (or Measurement) from the
>> PCI Express Base 3.1 specification is an optional Extended Capability
>> for discovering and controlling the distribution of a PTM Hierarchy.
>
> Thanks, applied.
>
> Could you please provide a test case, similar to those in tests/* ?
>
> 				Have a nice fortnight
>

Hi,

How do I generate those? Looks like a dump of lspci -vvnnxxxx against a 
specific device.

