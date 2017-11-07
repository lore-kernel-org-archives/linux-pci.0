Return-Path: <SRS0=RmR9=CF=infradead.org=rdunlap@kernel.org>
Return-Path: <SRS0=RmR9=CF=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH] pci: fix kernel-doc build warning
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>
References: <85dcffe7-1e6b-5735-2552-d35d127e392b@infradead.org>
 <20171107003355.GE9538@bhelgaas-glaptop.roam.corp.google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e756ace6-f821-db39-5a3b-11192ae55803@infradead.org>
Date: Mon, 6 Nov 2017 16:50:53 -0800
MIME-Version: 1.0
In-Reply-To: <20171107003355.GE9538@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/06/2017 04:33 PM, Bjorn Helgaas wrote:
> On Sun, Oct 29, 2017 at 05:07:11PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build error in kernel-doc notation:
>>
>> ../drivers/pci/pci.c:3479: ERROR: Unexpected indentation.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc:	Bjorn Helgaas <bhelgaas@google.com>
>> Cc:	linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/pci.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-414-rc7.orig/drivers/pci/pci.c
>> +++ lnx-414-rc7/drivers/pci/pci.c
>> @@ -3471,7 +3471,7 @@ EXPORT_SYMBOL(devm_pci_remap_cfgspace);
>>   * All operations are managed and will be undone on driver detach.
>>   *
>>   * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
>> - * on failure. Usage example:
>> + * on failure. Usage example::
> 
> I don't understand what's going on here.  Apparently there's something
> special about two colons?  I saw plenty of double colons in
> Documentation/, but I couldn't quickly find out what it means.

Sorry about my terseness.  The ending colon is not the problem.

The problem is in indentation in the example code, and changing to use
"::" tells the kernel-doc "reStructuredText" processor that the following
block is a literal block of some blob that should be kept as is.

> If kernel-doc thinks "example:" is a mistake, maybe we could recast
> the sentence as "Example usage:"?  Putting a double colon here makes
> the text look like a mistake to this human reader.
> 
>>   *
>>   *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
>>

Like you said, there will be lots of these "::" in source files.
There is one slight alternate, if it looks any better to you, to put the
"::" on a line by itself, like so:

 * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
 * on failure. Usage example:
 *::
 *
 *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
 *	if (IS_ERR(base))
 *		return PTR_ERR(base);
 */


I can resend the patch like that if you prefer it.

thanks,
-- 
~Randy
