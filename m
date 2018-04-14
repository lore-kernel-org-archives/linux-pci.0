Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeDNQJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Apr 2018 12:09:20 -0400
Date: Sat, 14 Apr 2018 11:09:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org,
        Rajat Jain <rajatja@google.com>
Subject: Re: Issue with Enable LTR while pcie_aspm off
Message-ID: <20180414160918.GA158153@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
 <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com>
 <20180413211651.GA80087@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4XC07tExSTOEoj9d5hkYWsm5QHUMD8rWorzz8S=V0yUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABe79T4XC07tExSTOEoj9d5hkYWsm5QHUMD8rWorzz8S=V0yUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 14, 2018 at 09:04:05AM +0530, Srinath Mannam wrote:
> I am sorry, in previous mail by mistake I have written L1.s support is
> not there, Actually I wanted to write L0s support is not there.
> L1 and L1ss support is there.

If your endpoint (and everything in the path) advertise both LTR and
L1ss support, that patch probably won't make a difference.

It *might* make a difference if only part of the path supports both,
because my reading of the spec is that L1ss requires LTR and LTR
requires the entire path to support LTR, and we currently don't
enforce that "entire path" part before enabling L1ss.

> But In our platform we required to disable ASPM.

We're trying to figure out exactly *why* you must disable ASPM.  If
it's because of a hardware defect, e.g., the device advertises ASPM
support but it's actually broken, we probably need to add a quirk.
Given the complexity of ASPM, it's surprising we don't have similar
quirks already.

> RC in our platform supports upto Gen3 only.

I don't think there's a connection between ASPM or LTR and the link
speed (Gen2, Gen3, etc), is there?

Bjorn
