Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33942 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbINBnc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Sep 2015 21:43:32 -0400
MIME-Version: 1.0
In-Reply-To: <55E580AF.6060302@arm.com>
References: <1441103408-8433-1-git-send-email-lftan@altera.com>
	<55E580AF.6060302@arm.com>
Date: Mon, 14 Sep 2015 09:43:30 +0800
Message-ID: <CAFiDJ59Q7+5eCUmRMcmk=EgQ7YH9Tn=SRBsVHGP0XNRUZoTuqA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Altera PCIe host controller driver with MSI support
From: Ley Foon Tan <lftan@altera.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 1, 2015 at 6:40 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 01/09/15 11:30, Ley Foon Tan wrote:
>> This is the 6th version of patch set to add support for Altera PCIe host
>> controller with MSI feature on Altera FPGA device families. This patchset
>> mainly resolve comments from Marc Zyngier in v5 and minor fixes.
>
> The merge window has just started, and I'm not going to go through
> another review at that stage - too many things in flight.
>
> Please ping me again once 4.3-rc1 is out.
>
Hi Marc

Do you have further comment on this patchset?
Thanks.

Regards
Ley Foon
