Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51000 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934520Ab2FHV6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jun 2012 17:58:41 -0400
Received: by dady13 with SMTP id y13so2885272dad.19
        for <linux-pci@vger.kernel.org>; Fri, 08 Jun 2012 14:58:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+NGFTzYNeSUpPVFJJYPTu7U-0PtbiL_8+JfeOsizRW2prgUxw@mail.gmail.com>
References: <loom.20120607T194858-986@post.gmane.org>
	<CAE9FiQWau+ko4JiEEjM=2xSH_7FPBr_ZYOm8YGpin2p97=12PQ@mail.gmail.com>
	<CA+NGFTzYNeSUpPVFJJYPTu7U-0PtbiL_8+JfeOsizRW2prgUxw@mail.gmail.com>
Date: Fri, 8 Jun 2012 14:58:41 -0700
Message-ID: <CAE9FiQVavmZckTW5X51F-dmSE13ZHZUDqDgZVvjzYc5qd64GMQ@mail.gmail.com>
Subject: Re: PCIe rescan not working
From: Yinghai Lu <yinghai@kernel.org>
To: Tom Carr <tkcarr03873@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 8, 2012 at 12:07 PM, Tom Carr <tkcarr03873@gmail.com> wrote:
>> >  I am sure I am not supply some piece of information that is important
>> > so let me
>> > know what else you need and I will provide it.
>>
>> should be bridge that 04:08.0 is on, does not have big enough range
>> after it is booted up.

please try:

echo 1 > /sys/bus/pci/devices/0000:00:01.2/remove

before

echo 1 > /sys/bus/pci/rescan

than should work.
