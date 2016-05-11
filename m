Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "jchandra@broadcom.com" <jchandra@broadcom.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
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
Message-ID: <57331290.7070104@semihalf.com>
Date: Wed, 11 May 2016 13:08:00 +0200
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriele,

On 11.05.2016 12:41, Gabriele Paoloni wrote:
> Hi Tomasz
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Tomasz Nowicki
>> Sent: 10 May 2016 16:20
>> To: helgaas@kernel.org; arnd@arndb.de; will.deacon@arm.com;
>> catalin.marinas@arm.com; rafael@kernel.org; hanjun.guo@linaro.org;
>> Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org; jchandra@broadcom.com
>> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
>> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; Wangyijing;
>> Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
>> acpi@lists.linaro.org; jcm@redhat.com; andrea.gallo@linaro.org;
>> dhdang@apm.com; jeremy.linton@arm.com; liudongdong (C);
>> cov@codeaurora.org; Tomasz Nowicki
>> Subject: [PATCH V7 00/11] Support for generic ACPI based PCI host
>> controller
>>
>>  From the functionality point of view this series may be split into the
>> following logic parts:
>> 1. New ECAM API and update for users of the pci-host-common API
>> 2. Necessary fixes as the preparation for using driver on ARM64.
>> 3. Use new MCFG interface and implement generic ACPI based PCI host
>> controller driver.
>> 4. Enable above driver on ARM64
>>
>> Patches has been built on top of 4.6-rc7 and can be found here:
>> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v7)
>>
>> This has been tested on Cavium ThunderX server. Any help in reviewing
>> and
>> testing is very appreciated.
>>
>> v6 -> v7
>> - drop quirks handling
>
> Maybe I missed something in the v6 discussion thread; when was it
> decided to drop quirk handling?

I had such requests in previous series.

>
> I think it is important to have this in place to accommodate different
> vendors. If the intention is to keep this patchset "clean" maybe
> we can add it as a separate patch on top later on...
>
> What¡¯s your view?

Yes, keeping these things separated should help in review. Obviously I 
agree that we need quirk handling but currently there is no 
implementation which we all agree upon. For the test, you can use quirk 
handling approach from the previous series until we sort out final solution.

Thanks,
Tomasz
