Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63054 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbaFWTJg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jun 2014 15:09:36 -0400
Received: by mail-ie0-f173.google.com with SMTP id y20so6173280ier.18
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 12:09:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53A839C6.5050102@dev.mellanox.co.il>
References: <53A839C6.5050102@dev.mellanox.co.il>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Jun 2014 13:09:15 -0600
Message-ID: <CAErSpo7xVvqYea8v624T8EyVf6skQccraAe_WYpzcf2tkWFLhg@mail.gmail.com>
Subject: Re: PCI/AER: AER in SRIOV environment
To: Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc: "Pandarathil, Vijaymohan R" <vijaymohan.pandarathil@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	"linux-rdma (linux-rdma@vger.kernel.org)"
	<linux-rdma@vger.kernel.org>,
	"yishaih@mellanox.com" <yishaih@mellanox.com>, liranl@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, Don]

On Mon, Jun 23, 2014 at 8:29 AM, Yishai Hadas
<yishaih@dev.mellanox.co.il> wrote:
> Hi Vijay,
> Trying to add AER support for Mellanox NIC in SRIOV environment, while
> evaluating/testing encountered a problem which led me to your
> patch accepted as part of kernel 3.8, commit ID
> "918b4053184c0ca22236e70e299c5343eea35304".
>
> Have some concerns/questions on:
> When working in SRIOV environment VFs may be un-attached, having no driver
> assigned to, or may be attached to Virtual machine to work in some
> pass-through mode.
> Once working in KVM setup there is pci-stub driver which is loaded in the
> HYP/PF for a given attached VF.
>
> I'm using the aer-inject kernel module and its corresponding aer-inject tool
> to simulate an error in the HYP.
> In both cases your commit will cause the AER recovery to fail as there is no
> driver assigned to PF's VFs that supports AER, comparing the code before
> your change.
>
> How such cases should work ?  my expectation was that the PF will get the
> error detected message then will recognize whether
> issue is its own or one of its VFs

I'm really not an AER expert, so help me understand this question of
recognizing whether an error is associated with a PF or a VF.

In terms of hardware, it looks like the device that detects an error
logs some information and sends an Error Message upstream.  The Root
Complex receives the message, captures the source ID from the Error
Message, and may generate an interrupt.  I expect this source ID can
be either a PF or a VF; there's no requirement that a VF error must be
reported as though it's from the PF, is there?

> and work accordingly, in current code
> looks like recovery failed as part of "voting" once there is no AER handler
> assigned to the VFs.

The commit you mentioned has to do with PCI_ERS_RESULT_NO_AER_DRIVER.
We use pci_walk_bus() to figure out whether all the devices in a
subtree have a driver.  What subtree is involved here?  I would expect
the VFs to be siblings of the PF, not children of it, so I'm not sure
where things went wrong.

Can you collect "lspci -vvv" output and maybe add some debug so we can
see exactly where the error is detected and what devices we're looking
at to conclude that one of them doesn't have a driver?

Bjorn
