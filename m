Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
From: dann frazier <dann.frazier@canonical.com>
Date: Thu, 9 Nov 2017 09:16:03 -0700
Message-ID: <CALdTtnsCXp9kone=VECSyPOi6kuYML8eU-TKHM+_ekhVoGSTYA@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] LPC: legacy ISA I/O support
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Corey Minyard <minyard@acm.org>,
 lorenzo.pieralisi@arm.com, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, rafael@kernel.org, linux-pci@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, John Garry <john.garry@huawei.com>,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 xuwei5@hisilicon.com, linuxarm@huawei.com, olof@lixom.net,
 Rob Herring <robh+dt@kernel.org>, benh@kernel.crashing.org,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Rowand <frowand.list@gmail.com>,
 Brian Starkey <brian.starkey@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 27, 2017 at 10:11 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> interface implemented on Hisilicon Hip06/Hip07 SoC.

fwiw, I tested this on one of our D05 boards and verified that the
IPMI SI worked fine.

Tested-by: dann frazier <dann.frazier@canonical.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
