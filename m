Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:64139 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaGLMJW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jul 2014 08:09:22 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so1671115lab.10
        for <linux-pci@vger.kernel.org>; Sat, 12 Jul 2014 05:09:21 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Add include guard to include/linux/pci_ids.h
References: <1404993911-10544-1-git-send-email-linux@rasmusvillemoes.dk>
	<20140710220233.GA21053@google.com>
Date: Sat, 12 Jul 2014 14:09:18 +0200
In-Reply-To: <20140710220233.GA21053@google.com> (Bjorn Helgaas's message of
	"Thu, 10 Jul 2014 16:02:33 -0600")
Message-ID: <87tx6mzslt.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> writes:

> On Thu, Jul 10, 2014 at 02:05:11PM +0200, Rasmus Villemoes wrote:
>> Adding an include guard frees the preprocessor from reparsing over
>> 2600 #defines in the cases where pci_ids.h is somehow included more
>> than once. This gives a tiny-but-measurable performance improvement
>> when compiling such files.
>> 
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> Applied to pci/misc for v3.17, thanks!
>

Great.

One thing I thought about, but which is likely undoable in practice:
There are only about 800 files which use any of the #defines in
pci_ids.h, but more than 3000 files include pci.h directly or
indirectly. Making those 800 include pci_ids.h directly and removing it
from pci.h could speed up compilation of the other 2200.

Rasmus
