Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36504 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbK2Ip3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2015 03:45:29 -0500
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] drivers:pci:hotplug Fix space prohibited between function name and open parenthesis '('
From: sasa bogicevic <brutallesale@gmail.com>
In-Reply-To: <1448566598.18647.12.camel@perches.com>
Date: Sun, 29 Nov 2015 09:45:27 +0100
Cc: bhelgaas@google.com, lenb@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <2881C4B7-AF00-42BD-A16E-6FFD3EC9A93C@gmail.com>
References: <1448553041-18601-1-git-send-email-brutallesale@gmail.com> <1448566598.18647.12.camel@perches.com>
To: Joe Perches <joe@perches.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> On Nov 26, 2015, at 8:36 PM, Joe Perches <joe@perches.com> wrote:
> 
> On Thu, 2015-11-26 at 16:50 +0100, Bogicevic Sasa wrote:
>> This fixes all errors "space prohibited between function name and
>> open parenthesis '(' " in all files in drivers/pci/hotplug folder
> 
> It's good when sending this sort of patch to add a bit of
> description like "git diff -w shows no differences" and that
> using scripts/objdiff also shows no difference.
> 
> Doing so shows that you've done a bit more than a mechanical
> transformation using something like:
> 
> $ ./scripts/checkpatch -f --types=spacing --fix-inplace <files>
> 
> and that you have verified your changes too.
> Ah ok, thanks for the info. Ill explore some more on what else can checkpatch.pl can do and resend all that needs to be corrected in that folder.
  Thanks, Sasa

