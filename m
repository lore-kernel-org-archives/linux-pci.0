Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
To: helgaas@kernel.org, will.deacon@arm.com, catalin.marinas@arm.com,
 rafael@kernel.org, Lorenzo.Pieralisi@arm.com
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
Cc: arnd@arndb.de, hanjun.guo@linaro.org, okaya@codeaurora.org,
 jchandra@broadcom.com, cov@codeaurora.org, dhdang@apm.com,
 ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com,
 mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
 wangyijing@huawei.com, msalter@redhat.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 jcm@redhat.com, andrea.gallo@linaro.org, jeremy.linton@arm.com,
 liudongdong3@huawei.com, gabriele.paoloni@huawei.com, jhugo@codeaurora.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <9a7047d4-04bd-cb89-dc37-8404d7b91bb8@semihalf.com>
Date: Fri, 9 Sep 2016 21:30:49 +0200
MIME-Version: 1.0
In-Reply-To: <1473449047-10499-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 09.09.2016 21:24, Tomasz Nowicki wrote:
> Quirk handling relies on an idea of simple static array which contains
> quirk enties. Each entry consists of identification information (IDs from
> standard header of MCFG table) along with custom pci_ecam_ops structure and
> configuration space resource structure. This way it is possible find
> corresponding quirk entries and override pci_ecam_ops and PCI configuration
> space regions.
>
> As an example, the last 3 patches present quirk handling mechanism usage for
> ThunderX.
>

This series can be found here:
git@github.com:semihalf-nowicki-tomasz/linux.git (branch: pci-acpi-quirk-v6)

Thanks,
Tomasz
