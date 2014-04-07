Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38553 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbaDGR6r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Apr 2014 13:58:47 -0400
Received: by mail-ig0-f179.google.com with SMTP id hl10so3936921igb.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Apr 2014 10:58:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5183143.FxBNM0xTAV@wuerfel>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <20140405001953.GE15806@google.com> <20140407083120.GE17163@e106497-lin.cambridge.arm.com>
 <5183143.FxBNM0xTAV@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 Apr 2014 11:58:24 -0600
Message-ID: <CAErSpo4iEV6khP63ZTF+YUTKi9WLFXzMv13nxw15y3qDg15Ztg@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper function.
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 7, 2014 at 5:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I think migrating other architectures to use the same code should be
> a separate effort from adding a generic implementation that can be
> used by arm64. It's probably a good idea to have patches to convert
> arm32 and/or microblaze.

Let me reiterate that I am 100% in favor of replacing arch-specific
code with more generic implementations.

However, I am not 100% in favor of doing it as separate efforts
(although maybe I could be convinced).  The reasons I hesitate are
that (1) if only one architecture uses a new "generic" implementation,
we really don't know whether it is generic enough, (2) until I see the
patches to convert other architectures, I have to assume that I'm the
one who will write them, and (3) as soon as we add the code to
drivers/pci, it becomes partly my headache to maintain it, even if
only one arch benefits from it.

Please don't think I'm questioning anyone's intent or good will.  It's
just that I understand the business pressures, and I know how hard it
can be to justify this sort of work to one's management, especially
after the immediate problem has been solved.

Bjorn
