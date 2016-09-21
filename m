Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
To: Bjorn Helgaas <helgaas@kernel.org>, cov@codeaurora.org
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <20160920192636.GB4941@localhost>
 <0429663d51ed8e93fb0c96261dd2ecc7@codeaurora.org>
 <20160921131107.GB10804@localhost>
Cc: Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com,
 catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com,
 arnd@arndb.de, hanjun.guo@linaro.org, jchandra@broadcom.com, dhdang@apm.com,
 ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com,
 mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
 wangyijing@huawei.com, msalter@redhat.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 jcm@redhat.com, andrea.gallo@linaro.org, jeremy.linton@arm.com,
 liudongdong3@huawei.com, gabriele.paoloni@huawei.com, jhugo@codeaurora.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <25529f96-3e80-0524-82d8-6eeb517df5b5@codeaurora.org>
Date: Wed, 21 Sep 2016 10:07:36 -0400
MIME-Version: 1.0
In-Reply-To: <20160921131107.GB10804@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 9/21/2016 9:11 AM, Bjorn Helgaas wrote:
> On Tue, Sep 20, 2016 at 09:15:14PM -0400, cov@codeaurora.org wrote:
>> Hi Bjorn, Thomasz,
>>

>>
>> Did you delete this because there were no current users, because you'd
>> prefer users just use "-1", or for some other reason?
> 
> I removed it because there were no users of it and, more importantly,
> the code doesn't implement support for it.

Is it possible to queue up Cov's patch as part of this effort once he 
rebases and sends an updated version? Cov will have to implement something
else now.



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
