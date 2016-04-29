Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54837 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbcD2WD6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Apr 2016 18:03:58 -0400
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR
 allocation
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461795744-28837-1-git-send-email-agraf@suse.de>
 <20160428162035.GB19785@localhost> <57223D46.7070102@suse.de>
 <20160428180641.GA25125@localhost> <57228317.1030808@suse.de>
 <20160429134126.GA949@localhost>
 <CAKv+Gu-4vqT-tQXdwJbLV0r3FhtrYk=TOWxDYS6LjG_BNf=b_A@mail.gmail.com>
 <20160429200609.GA28261@localhost>
 <35998183-0322-49D4-91CD-4D441577C44F@linaro.org> <5723C956.4040907@suse.de>
 <20160429213751.GB5359@localhost> <5723D7AF.3080108@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <5723DA4B.5010501@suse.de>
Date: Sat, 30 Apr 2016 00:03:55 +0200
MIME-Version: 1.0
In-Reply-To: <5723D7AF.3080108@suse.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 29.04.16 23:52, Alexander Graf wrote:
> 
> 
> On 29.04.16 23:37, Bjorn Helgaas wrote:
>
> Can you point me to the code that does "read[ing] the BARs"? So far my
> impression was that we don't even try to read out the current BAR values
> from pci config space, but I can't claim I fully grasp the Linux pci
> code quite yet.

I should've probably read Lorenzos email more closely before - it
contains the pointer.


Alex
