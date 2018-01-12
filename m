Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:34181 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933957AbeALPR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 10:17:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180112150744.sjntmpas5noaub6g@earth.universe>
References: <20180112150744.sjntmpas5noaub6g@earth.universe>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2018 13:17:26 -0200
Message-ID: <CAOMZO5BpJDoeZVaD+c600ci5rmEJ0kh_er1voJxsyXR4BdjFpw@mail.gmail.com>
Subject: Re: Regression due to "PCI: Do not allocate more buses than available
 in parent"
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Ray <ian.ray@ge.com>, Nandor Han <nandor.han@ge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sebastian,

On Fri, Jan 12, 2018 at 1:07 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi,
>
> I have an ARM/DT based system [0], that no longer finds its ethernet cards
> behind a PCIe switch. I bisected the problem and ended up on
> a20c7f36bd3d. I tried providing some space using the suggested "pci=hpbussize=<N>",
> but it does not seem to work.
>
> I added dmesg for working, broken and broken + parameter below. At
> the moment I would say this is a regression and the commit should be
> reverted.

Does this patch fix the problem?
https://patchwork.ozlabs.org/patch/857566/
