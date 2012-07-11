Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37285 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab2GKSt1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 14:49:27 -0400
Received: by vbbff1 with SMTP id ff1so982752vbb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 11:49:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
	<1340437325-29282-3-git-send-email-yinghai@kernel.org>
	<CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
	<20120711162120.GA17988@google.com>
	<CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
	<CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
Date: Wed, 11 Jul 2012 11:49:26 -0700
Message-ID: <CAE9FiQVbaYszsqq6WYENQu18a52m2fD9svtdFV2y4DeDnYWJcA@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 11:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> What's the connection with HP_SUPR_RM()?  Is it just a coincidence
> that chipsets that set the "Hot-Plug Surprise" bit don't have this
> problem with the Presence Detect State bit?
>
> Using HP_SUPR_RM() seems like a totally bogus way to work around a
> presence detect issue.

then we should blame the spec.

and if you do the above changing, when plug the card into system,
kernel will bring that card online automatically without press
attention button.
that will be big change.

Thanks

Yinghai
