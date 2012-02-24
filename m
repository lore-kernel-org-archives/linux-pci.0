Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47245 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab2BXGkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 01:40:15 -0500
MIME-Version: 1.0
In-Reply-To: <20120223124426.2631b779@jbarnes-desktop>
References: <1329370832-2253-1-git-send-email-yinghai@kernel.org>
	<1329370832-2253-2-git-send-email-yinghai@kernel.org>
	<20120223124426.2631b779@jbarnes-desktop>
Date: Thu, 23 Feb 2012 22:40:14 -0800
Message-ID: <CAE9FiQW74Q+M4YCFzdSgt2bnqRkq+CSXyYL9X0oqJvP0isS8cw@mail.gmail.com>
Subject: Re: [PATCH -v2 1/4] PCI: Add class support in quirk handling
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 23, 2012 at 12:44 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>
> I like this series, a few comments:
>  - class and class_shift everywhere (in pci_fixup {} and the new
>    macros) for readability

ok.

>  - split the individual quirk fixes into separate patches (makes it
>    easier to revert or identify if one breaks)

yes

will send updated patches shortly.

>  - the reassigndev patch looks like a good one independent of the
>    series

yes, you can apply that separately.

Thanks

       Yinghai
yes.
