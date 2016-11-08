Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbcKHQtr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 11:49:47 -0500
Date: Tue, 8 Nov 2016 16:49:49 +0000
From: Will Deacon <will.deacon@arm.com>
To: John Garry <john.garry@huawei.com>
Cc: "zhichang.yuan" <yuanzhichang@hisilicon.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        benh@kernel.crashing.org, minyard@acm.org, arnd@arndb.de,
        catalin.marinas@arm.com, gabriele.paoloni@huawei.com,
        zhichang.yuan02@gmail.com, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
        linuxarm@huawei.com, olof@lixom.net, robh+dt@kernel.org,
        zourongrong@gmail.com, linux-serial@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, kantyzc@163.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Message-ID: <20161108164948.GG20591@arm.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108161245.GD20591@arm.com>
 <8adfe182-4939-479d-6013-25ec40021b20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8adfe182-4939-479d-6013-25ec40021b20@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 04:33:44PM +0000, John Garry wrote:
> On 08/11/2016 16:12, Will Deacon wrote:
> >On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
> >>+static inline void arm64_set_extops(struct extio_ops *ops)
> >>+{
> >>+	if (ops)
> >>+		WRITE_ONCE(arm64_extio_ops, ops);
> >
> >Why does this need to be WRITE_ONCE? You don't have READ_ONCE on the reader
> >side. Also, what if multiple drivers want to set different ops for distinct
> >address ranges?
> 
> I think that the idea here is that we only have possibly one master in the
> system which offers indirectIO backend, so another one could not possibly
> re-set this value.

Why is that assumption valid, and why does WRITE_ONCE help there? It's not
ONCE as in WARN_ONCE, more ONCE as in exactly-once-per-invocation.

> >>diff --git a/arch/arm64/kernel/extio.c b/arch/arm64/kernel/extio.c
> >>new file mode 100644
> >>index 0000000..647b3fa
> >>--- /dev/null
> >>+++ b/arch/arm64/kernel/extio.c
> >>@@ -0,0 +1,27 @@
> >>+/*
> >>+ * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
> >>+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License version 2 as
> >>+ * published by the Free Software Foundation.
> >>+ *
> >>+ * This program is distributed in the hope that it will be useful,
> >>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>+ * GNU General Public License for more details.
> >>+ *
> >>+ * You should have received a copy of the GNU General Public License
> >>+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >>+ */
> >>+
> >>+#include <linux/io.h>
> >>+
> >>+struct extio_ops *arm64_extio_ops;
> >>+
> >>+
> >>+BUILD_EXTIO(b, u8)
> >>+
> >>+BUILD_EXTIO(w, u16)
> >>+
> >>+BUILD_EXTIO(l, u32)
> >
> >Is there no way to make this slightly more generic, so that it can be
> >re-used elsewhere? For example, if struct extio_ops was common, then
> >you could have the singleton (which maybe should be an interval tree?),
> >type definition, setter function and the BUILD_EXTIO invocations
> >somewhere generic, rather than squirelled away in the arch backend.
> >
> The concern would be that some architecture which uses generic higher-level
> ISA accessor ops, but have IO space, could be affected.

You're already adding a Kconfig symbol for this stuff, so you can keep
that if you don't want it on other architectures. I'm just arguing that
plumbing drivers directly into arch code via arm64_set_extops is not
something I'm particularly fond of, especially when it looks like it
could be avoided with a small amount of effort.

Will
