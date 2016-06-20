Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20160606230636.20936.29083.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160606230636.20936.29083.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Tyler Baker <tyler.baker@linaro.org>
Date: Mon, 20 Jun 2016 09:56:45 -0700
Message-ID: <CANMBJr41muA9mTNAa6MtWuMmeNLQxT4NjLe45=ExdFiH8vwzyw@mail.gmail.com>
Subject: Re: [PATCH v1 15/25] PCI: generic: Free resource list close to where
 it's allocated
To: Bjorn Helgaas <bhelgaas@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Kevin's boot bot <khilman@kernel.org>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Simon Horman <horms@verge.net.au>,
 linux-tegra@vger.kernel.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-renesas-soc@vger.kernel.org, Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 6 June 2016 at 16:06, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Previously we allocated the PCI resource list in
> gen_pci_parse_request_of_pci_ranges(), but if we had an error, we freed it
> on error in gen_pci_init().
>
> Reorder gen_pci_init() so we can take care of error path cleanup in
> gen_pci_parse_request_of_pci_ranges() instead.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

The kernelci.org bot has reported[0] new qemu-aarch64
(arm64-defconfig) boot failures[1][2] in next-20160620. I've
bisected[3] this boot failure down to this patch, and confirmed
reverting it on top of next-20160620 resolves the boot issue.

I have not investigated further, but you can easily reproduce[4] the
boot failure on an x86 host running qemu-system-aarch64 (I'm running
qemu-system 2.6).

Cheers,

Tyler

[0] https://kernelci.org/boot/all/job/next/kernel/next-20160620/
[1] https://storage.kernelci.org/next/next-20160620/arm64-defconfig/lab-cambridge/boot-apm-mustang-kvm-guest.txt
[2] https://storage.kernelci.org/next/next-20160620/arm64-defconfig/lab-tbaker/boot-qemu-aarch64,legacy.txt
[3] http://hastebin.com/segiruribu.vbs
[4] http://hastebin.com/dafuzicuyi.avrasm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
