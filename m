Return-Path: <svarbanov@mm-sol.com>
Return-Path: <svarbanov@mm-sol.com>
Subject: Re: [PATCH v2 0/4] PCI: qcom: Cleanups
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160654.GS4308@localhost>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <daf16f7c-63ec-0096-0ca8-e7eb8a21f1b6@mm-sol.com>
Date: Thu, 13 Oct 2016 11:31:52 +0300
MIME-Version: 1.0
In-Reply-To: <20161012160654.GS4308@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 10/12/2016 07:06 PM, Bjorn Helgaas wrote:
> On Wed, Oct 12, 2016 at 08:59:54AM -0500, Bjorn Helgaas wrote:
>>   - Remove platform drvdata because it appears unused (we called
>>     platform_set_drvdata() but not platform_get_drvdata()).
>>
>>   - Remove redundant struct members.
>>
>> Nothing here should change the behavior of the driver.
>>
>> Changes from v1:
>>   I dropped the following patch because it was a lot of churn for
>>   questionable benefit:
>>     PCI: qcom: Name private struct pointer "qcom" consistently
>>
>> ---
>>
>> Bjorn Helgaas (4):
>>       PCI: qcom: Remove unused platform data
>>       PCI: qcom: Remove redundant struct qcom_pcie.dbi
>>       PCI: qcom: Remove redundant struct qcom_pcie.dev
>>       PCI: qcom: Reorder struct qcom_pcie
>>
>>
>>  drivers/pci/host/pcie-qcom.c |   30 ++++++++++++------------------
>>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> I applied these to pci/host-qcom for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.

Thanks for the clean up!

Reviewed-by: Stanimir Varbanov <svarbanov@mm-sol.com>

regards,
Stan
