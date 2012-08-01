Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42883 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753473Ab2HANyE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 09:54:04 -0400
Received: by lahd3 with SMTP id d3so4673061lah.19
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2012 06:54:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120801075252.6FC0A11FC70@bugzilla.kernel.org>
References: <bug-43238-41252@https.bugzilla.kernel.org/> <20120801075252.6FC0A11FC70@bugzilla.kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 1 Aug 2012 07:53:42 -0600
Message-ID: <CAErSpo7tHn7M9wnEuysrNHet2UEQzKOJSFrACe+w3Jnp=+u4FA@mail.gmail.com>
Subject: Re: [Bug 43238] No interrupts on add-in PCI ethernet card - Intel H77
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Maybe Win7 already know this and has a quirk for that, usually new HW will be
> heavily tested on Windows before going to market.

In comment #35, Lubos points out that it's unlikely Windows could have
a quirk because Win7 was released before the motherboard and he
installed no Intel drivers.
