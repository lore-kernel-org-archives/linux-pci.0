Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:40477 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902AbaDVQCY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Apr 2014 12:02:24 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so3036750igc.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2014 09:02:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
References: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 22 Apr 2014 10:01:58 -0600
Message-ID: <CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com>
Subject: Re: Intel NIC testing on ARM
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 22, 2014 at 3:50 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> Has anybody tested below Intel I210 NIC card using igb driver on ARM?
>
> http://www.intel.com/content/www/us/en/ethernet-controllers/ethernet-controller-i210-i211-family.html
>
> It hangs during configuration stage for me. Actually it shows BAR0
> requirement as 0 which is non-zero for x86.

Can you give any more details about this, e.g., a complete dmesg log,
which should contain details about enumeration and resource
allocation?
