Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37024 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbLJX2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2015 18:28:35 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] drivers:pci:hotplug Fix all space prohibited before that ,
From: sasa bogicevic <brutallesale@gmail.com>
In-Reply-To: <20151210232446.GA17458@localhost>
Date: Fri, 11 Dec 2015 00:28:32 +0100
Cc: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <AA8FDE92-4E81-49D6-8BE8-E38DDC6B8303@gmail.com>
References: <1449744040-76428-1-git-send-email-brutallesale@gmail.com> <20151210224700.GD367@localhost> <6CF18E87-8037-4BD5-82EE-5CCA2BCE8A75@gmail.com> <20151210232446.GA17458@localhost>
To: Bjorn Helgaas <helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cool Ill group all whitespace issues in one patch, compile everything and use objdiff to make sure I didnt brake anything and resend.

Thanks, Sasa
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Dec 11, 2015, at 00:24, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Fri, Dec 11, 2015 at 12:07:03AM +0100, sasa bogicevic wrote:
>> I wanted to start with approach one error one folder so I did “space prohibited before ,” in just hotplug folder. I used checkpatch script to see if I nailed it and the output was fine.
>> When I do grep -rl I also get the same result eventhou when I look at the, for example, drivers/pci/hotplug/shpchp_ctrl.c there is no space before comma anywhere. I double checked it. I didn’t do header files unfortunately so that errors are expected I guess.
>> 
>> ./scripts/checkpatch.pl --file --terse drivers/pci/hotplug/shpchp_ctrl.c 
>> drivers/pci/hotplug/shpchp_ctrl.c:190: WARNING: Block comments use * on subsequent lines
>> drivers/pci/hotplug/shpchp_ctrl.c:264: WARNING: line over 80 characters
>> drivers/pci/hotplug/shpchp_ctrl.c:265: WARNING: line over 80 characters
>> drivers/pci/hotplug/shpchp_ctrl.c:344: ERROR: return is not a function, parentheses are not required
>> drivers/pci/hotplug/shpchp_ctrl.c:359: ERROR: return is not a function, parentheses are not required
>> drivers/pci/hotplug/shpchp_ctrl.c:439: WARNING: Possible unnecessary 'out of memory' message
>> drivers/pci/hotplug/shpchp_ctrl.c:463: WARNING: space prohibited between function name and open parenthesis '('
>> drivers/pci/hotplug/shpchp_ctrl.c:478: WARNING: space prohibited between function name and open parenthesis '('
>> drivers/pci/hotplug/shpchp_ctrl.c:569: WARNING: space prohibited between function name and open parenthesis '('
>> drivers/pci/hotplug/shpchp_ctrl.c:626: WARNING: space prohibited between function name and open parenthesis ‘('
>> total: 2 errors, 8 warnings, 730 lines checked
>> 
>> I used objdiff to record and see if I didn’t change anything and I got no output so I guess all is good, don’t know why grep finds “ ,” it is a mystery to me since I am on my working branch, looking at a file and it is not there. Can you also take a look on your side ? 
>> 
>> I wanted to do one small thing and when I see that it is good and accepted from you then do all warnings and errors one by one.
> 
> OK, makes sense.  I think you're on the right track, and if you extend
> this patch to all of drivers/pci, I'll apply it.
> 
> I see you found the lines that checkpatch didn't complain about.
> Maybe checkpatch doesn't look at things inside quoted strings?  That's
> just a guess; I don't use checkpatch regularly.
> 
> If you plan to do other things, e.g., removing spaces between the
> function name and open parenthesis, I'd like to have all the "white
> space-only" changes in a single patch.
> 
> Bjorn

