Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta12.ai270.net ([94.126.40.179]:55232 "EHLO
	out-mta10.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932271AbcASRlx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 12:41:53 -0500
From: Richard F <lists@keynet-technology.com>
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost> <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost>
Cc: linux-pci@vger.kernel.org
Message-ID: <569E755D.4050207@keynet-technology.com>
Date: Tue, 19 Jan 2016 17:41:49 +0000
MIME-Version: 1.0
In-Reply-To: <20160119033839.GA3339@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I rebuilt 4.4.0, as I noticed a warning about microcode in the .config
which I fixed (assumed changed function).  Another DMESG posted here
https://bugzilla.kernel.org/show_bug.cgi?id=110851

Still no joy unfortunately.

thanks
Richard

On 19/01/2016 03:38, Bjorn Helgaas wrote:
> On Mon, Jan 18, 2016 at 02:48:59PM +0000, Richard F wrote:
>> I posted a DMESG with 4.3.3 to Bugzilla now.
>> 4.4.0 crashed on boot, not sure why yet.
> 
