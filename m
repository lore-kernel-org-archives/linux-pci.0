Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm24-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.161]:59871 "EHLO
        nm24-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751021AbcKXXqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2016 18:46:44 -0500
Date: Thu, 24 Nov 2016 21:39:57 -0200
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Cc: clemens@ladisch.de, linux-pci@vger.kernel.org
Subject: Multiple problems with the Linux kernel on an AMD desktop
Message-ID: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear developers,

I have been having problems that are starting to accumulate on my main
Desktop and I decided to ask here for help, since I perceive that the
majority (not all, of course) of developers are likely to use recent,
Intel-based systems for their x86-64 work.

My desktop has an AMD Phenon II X4 910 processor and a corresponding chipset
(I can provide many, many details).

Before I go on describing the problems that I have, I want to say that I can
bisect the kernel, apply patches and give feedback for the problems that I
am seeing.

The problems that I am seeing are the following:

* I have never been able to boot this computer of mine without the option
  irqpoll---otherwise, I get the nobody cared message. I just didn't pay
  much attention, despite me booting with many different kernels and
  distributions.
  
  With a particular Fedora, I reported the problem, but It was coalesced
  with many other "nobody cared" messages and once that particular Fedora
  release was EOL'ed, the bug report was closed.
  
* Besides the previous problem, starting with Debian's kernel 4.5, I am
  seeing bazillion messages like the following:

        (...)
        [  198.701170] hpet_rtc_timer_reinit: 3 callbacks suppressed
        [  198.701180] hpet1: lost 9 rtc interrupts
        [  198.893025] hpet1: lost 6 rtc interrupts
        [  199.261331] hpet1: lost 18 rtc interrupts
        [  199.421005] hpet1: lost 5 rtc interrupts
        [  200.301213] hpet1: lost 38 rtc interrupts
        [  200.620908] hpet1: lost 10 rtc interrupts
        [  200.780805] hpet1: lost 4 rtc interrupts
        [  201.020950] hpet1: lost 9 rtc interrupts
        [  201.132796] hpet1: lost 2 rtc interrupts
        [  201.420817] hpet1: lost 12 rtc interrupts
        [  203.818978] hpet_rtc_timer_reinit: 6 callbacks suppressed
        [  203.818988] hpet1: lost 9 rtc interrupts
        [  204.332489] hpet1: lost 13 rtc interrupts
        [  204.859603] hpet1: lost 28 rtc interrupts
        [  205.452624] hpet1: lost 33 rtc interrupts
        [  205.580324] hpet1: lost 3 rtc interrupts
        [  206.332410] hpet1: lost 42 rtc interrupts
        [  206.457489] hpet1: lost 3 rtc interrupts
        [  206.652160] hpet1: lost 7 rtc interrupts
        [  206.812568] hpet1: lost 4 rtc interrupts
        [  206.972045] hpet1: lost 4 rtc interrupts
        [  208.907139] hpet_rtc_timer_reinit: 3 callbacks suppressed
        [  208.907150] hpet1: lost 48 rtc interrupts
        [  213.469016] hpet1: lost 291 rtc interrupts
        [  214.186567] hpet1: lost 43 rtc interrupts
        [  214.984415] hpet1: lost 42 rtc interrupts
        [  215.304994] hpet1: lost 13 rtc interrupts
        [  217.448507] hpet1: lost 3 rtc interrupts
        [  218.247600] hpet1: lost 48 rtc interrupts
        (...)

  I tested this with Ubuntu's pre-compiled/unpatched kernel 4.5-rc1 and I
  also get this problem, but with slightly different messages (which I guess
  are due to debugging being enabled):

        (...)
        [  371.320075] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458760
        [  371.320079] evbug: Event. Dev: input6, Type: 1, Code: 18, Value: 0
        [  371.320081] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  371.448069] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458774
        [  371.448072] evbug: Event. Dev: input6, Type: 1, Code: 31, Value: 1
        [  371.448074] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  371.480062] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458774
        [  371.480067] evbug: Event. Dev: input6, Type: 1, Code: 31, Value: 0
        [  371.480069] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  371.608060] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458774
        [  371.608064] evbug: Event. Dev: input6, Type: 1, Code: 31, Value: 1
        [  371.608066] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  371.688057] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458774
        [  371.688061] evbug: Event. Dev: input6, Type: 1, Code: 31, Value: 0
        [  371.688063] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  371.768051] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458792
        [  371.768055] evbug: Event. Dev: input6, Type: 1, Code: 28, Value: 1
        [  371.768057] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  371.786065] hpet1: lost 90 rtc interrupts
        [  371.803655] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458792
        [  371.803660] evbug: Event. Dev: input6, Type: 1, Code: 28, Value: 0
        [  371.803662] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  372.194719] hpet1: lost 23 rtc interrupts
        [  373.527954] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458827
        [  373.527958] evbug: Event. Dev: input6, Type: 1, Code: 104, Value: 1
        [  373.527961] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  373.607943] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458827
        [  373.607947] evbug: Event. Dev: input6, Type: 1, Code: 104, Value: 0
        [  373.607949] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  373.895924] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458827
        [  373.895928] evbug: Event. Dev: input6, Type: 1, Code: 104, Value: 1
        [  373.895930] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  373.959913] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458827
        [  373.959917] evbug: Event. Dev: input6, Type: 1, Code: 104, Value: 0
        [  373.959920] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  374.087908] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458827
        [  374.087911] evbug: Event. Dev: input6, Type: 1, Code: 104, Value: 1
        [  374.087913] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
        [  374.199899] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458827
        (...)

  I reported the problem above at
  https://bugzilla.kernel.org/show_bug.cgi?id=120251 in June, when I was
  running Debian's kernel 4.6.
  
  I included many details there about my hardware configuration, but, of
  course, I can copy them here in email for convenience.

* Besides *both* problems listed above, starting with Debian's kernel 4.8, I
  am seeing a very strange problem: when I was scanning some documents on my
  (USB) HP PSC 1610, it *always* hangs within about 15% of the work done.
  
  I discovered this while, as a single father, scanning some spiderman
  drawings to let my 4 y.o. boy, so that he could paint on them.
  
  This is 100% reproducible with kernel 4.8 and, with kernel 4.7 (dropped
  from Debian's next release), I don't have this 3rd problem.


Once again, I can bisect the kernel, apply patches and give feedback for the
problems that I am seeing. Just let me know what is necessary and I will do
what I'm instructed.

Please, keep me CC'ed as I'm not currently subscribed to the mailing lists.
Also, feel free to drop/adjust the list of recipients as appropriate.


Thanks a lot,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://rb.doesntexist.org/blog : Projects : https://github.com/rbrito/
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
