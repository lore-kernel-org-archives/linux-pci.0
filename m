Return-Path: <SRS0=QMlO=AC=axtens.net=dja@kernel.org>
Return-Path: <SRS0=QMlO=AC=axtens.net=dja@kernel.org>
From: Daniel Axtens <dja@axtens.net>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Liuxinliang \(Matthew Liu\)" <z.liuxinliang@hisilicon.com>, Zou Rongrong <zourongrong@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Airlie <airlied@linux.ie>, "Vetter\, Daniel" <daniel.vetter@intel.com>, Alex Williamson <alex.williamson@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, Lukas Wunner <lukas@wunner.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 0/3] Split default display handling out from VGA arbiter
In-Reply-To: <CAKv+Gu84njSF5uOvNtknGdOd5auU7zw9scFeTq5v-=OhExgOqA@mail.gmail.com>
References: <20170901072744.2409-1-dja@axtens.net> <CAKv+Gu84njSF5uOvNtknGdOd5auU7zw9scFeTq5v-=OhExgOqA@mail.gmail.com>
Date: Fri, 01 Sep 2017 21:34:03 +1000
Message-ID: <877exi4pqs.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Hi Ard,

> If we are all in agreement that fixing X is not an option, I think
> this is a reasonable approach

This did come up in discussion at some earlier point in one of the many
spins we've done of this - I don't remember if you brought it up or
someone else did - but my concern was this: If it were just X we would
be fine, but if we go down that path I'm worried about also having to
fix Mir/Wayland/whatever-the-new-exciting-display-server-is-this-week,
ad nauseum.

> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks!

Regards,
Daniel
