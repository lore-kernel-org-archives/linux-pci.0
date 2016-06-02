Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "jchandra@broadcom.com" <jchandra@broadcom.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
Cc: "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
 "mw@semihalf.com" <mw@semihalf.com>,
 "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
 "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
 Wangyijing <wangyijing@huawei.com>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
 "msalter@redhat.com" <msalter@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>,
 "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
 "dhdang@apm.com" <dhdang@apm.com>,
 "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
 "liudongdong (C)" <liudongdong3@huawei.com>,
 "cov@codeaurora.org" <cov@codeaurora.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <574FF3BE.4010903@semihalf.com>
Date: Thu, 2 Jun 2016 10:52:14 +0200
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriele,

On 01.06.2016 09:36, Gabriele Paoloni wrote:
> I think maybe it is worth to post this quirk mechanism as RFC on
> top of this v8 patchset, so that we can start to review it and
> make some progress on the quirks.

I've just posted my RFC patches, please see:
https://patchwork.ozlabs.org/patch/629121/

We can start review from there so that this series is not blocked.

Thanks,
Tomasz
