Return-Path: <SRS0=+/lQ=6D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D399C2BA2B
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 03:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAB021D79
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 03:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="iHZ0ELFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDSDyR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 18 Apr 2020 23:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725819AbgDSDyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 23:54:17 -0400
X-Greylist: delayed 2223 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Apr 2020 20:54:17 PDT
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0DC061A0C;
        Sat, 18 Apr 2020 20:54:16 -0700 (PDT)
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 92185140955;
        Sun, 19 Apr 2020 05:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587268454; bh=BYDbtyv4nsggP9ZOImNeNYU5cfb9ub3Bxar3NjW4DCY=;
        h=Date:From:To;
        b=iHZ0ELFVv7S1oXX27Yy17K859cLh6IRZ3hqbrADg9MCZXsgxbJuadpxhay6TDgUaZ
         M4ypt2Jwz6z8zHiYv9xruqiBdtXvM+QNbF4xeLafT5QKiaUpmV779D4gYFJ8Rthe0/
         KCLDSWXgFHtmfZkdXpCjE1JBapuIhknA34pnjC1U=
Date:   Sun, 19 Apr 2020 05:54:14 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/8] dts: aardvark: Route pcie reset pin to gpio
 function and define reset-gpios for pcie
Message-ID: <20200419055414.06ac7c0d@nic.cz>
In-Reply-To: <20200415160348.1146-3-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
        <20200415160348.1146-3-pali@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Apr 2020 18:03:47 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Marvell version of u-boot for Espressobin set pcie reset pin to gpio and
> toggle it when initializing u-boot aardvark driver.
>=20
> To not depend on bootloader version and state of Espressobin HW, route pc=
ie
> reset pin to gpio function and define reset-gpios also in kernel. So pcie
> aardvark driver can trigger needed reset.
>=20
> Turris MOX dts file has already defined reset-gpios and configured pcie
> reset pin to gpio function, so unify Espressobin and Turris MOX dts files.
>=20

Lets specify in the commit message the other information we found out.

This pin, according to specification, can be in two modes:
 - GPIO (controlled by the GPIO subsystem)
 - EP_PCIE1_Resetn (which should be controlled by PCIe subsystem)

Commit f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready
before training link") says that when pinctrl driver changes this
pin's mode from GPIO to PCIe, the signal is asserted for a little
while. Since this pin is in GPIO mode after reset (and if U-Boot probes
its own pci-aardvark driver, it also leaves it in GPIO mode), this
always happens.

We found out that we are unable to control this pin when in PCIe mode.
There is a register in the PCIe registers of this SOC, called
PERSTN_GPIO_EN (D0088004[3]), but changing the value of this register
does not change the pin output when measuring with voltmeter.
We do not know if this is a bug in the SOC, or if it works only when
PCIe controller is in a certain state.

So now the state of things is that the PERST signal is issued, but only
by chance, due to pinctrl machinations mentioned above. We think that
the PERST signal should be instead issued in a known way from the
pci-aardvark driver, therefore we change the function of this pin to
GPIO, so that the driver can issue it via GPIO subsystem.


Some of this explanation should also go as a comment into the dtsi file.
