Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54205 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165AbbA1Uj1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 15:39:27 -0500
Received: by mail-ie0-f177.google.com with SMTP id vy18so24791268iec.8
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 12:39:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVLxP5vKsrZ2T9-uGLrDYGHTG2QO9-52-C-XVQ227gLwA@mail.gmail.com>
References: <54C81B4E.7060900@nwtrail.com> <CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
 <CAE9FiQVLxP5vKsrZ2T9-uGLrDYGHTG2QO9-52-C-XVQ227gLwA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Jan 2015 10:46:43 -0600
Message-ID: <CAErSpo67cAFGPCra5EDMN9FtRaV6ZtvzQA3fB=OwY6z=xJ9wvg@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
To: Yinghai Lu <yinghai@kernel.org>
Cc: pjay@nwtrail.com, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 27, 2015 at 10:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jan 27, 2015 at 8:02 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Would you mind opening a report at http://bugzilla.kernel.org and
>> attaching the complete dmesg logs from both kernels to it?  If there
>> was no working kernel, collect a log from v3.19-rc6 with
>> "pci=realloc=off" instead.
>
> would be better if with "debug ignore_loglevel pci=realloc=off".

This is unrelated to the bug, and the parameters Yinghai suggested are
fine, but just out of curiosity , I thought "debug" and
"ignore_loglevel" only affected the output that goes to the console.

"ignore_loglevel" is handled by ignore_loglevel_setup() in
kernel/printk.c; it sets "ignore_loglevel = true".  I think "debug" is
handled by debug_kernel() in init/main.c; it sets "console_loglevel =
CONSOLE_LOGLEVEL_DEBUG".  But there are about a million "debug"
occurrences in the kernel, so maybe it does more than just set
console_loglevel.

The net effect is that I thought:

  - The dmesg log always contains everything, regardless of the
console_loglevel.
  - Using "ignore_loglevel" means everything goes to the console, in
addition to being in dmesg, regardless of what console_loglevel is.

So isn't it enough to just collect the dmesg log, without using
"debug" or "ignore_loglevel"?  Obviously, if the system doesn't boot,
you need to collect a console log, and then you would need
"ignore_loglevel".

And if you use "ignore_loglevel", isn't that enough by itself?  I
wouldn't think using "debug" in addition would make any difference.
Or maybe "debug" also turns on some dynamic debugging magic or
something?  If it does, that might be worth mentioning in
kernel-parameters.txt.

Bjorn
