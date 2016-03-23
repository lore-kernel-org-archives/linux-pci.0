Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52062 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcCWECR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Mar 2016 00:02:17 -0400
Message-ID: <56F21542.4080900@intel.com>
Date: Wed, 23 Mar 2016 12:02:10 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Re: [RFC v2] PCI: PTM Driver
References: <1458701271-1866-1-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1458701271-1866-1-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/23/2016 10:47, Yong, Jonathan wrote:
> Hello LKML,
>
> This is a preliminary implementation of the PTM[1] support driver, the code
> is obviously hacked together and in need of refactoring. This driver has
> only been tested against a virtual PCI bus.
>

My bad, v2 was missing a "void" return type in the stubs.


