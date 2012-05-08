Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:47905 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944Ab2EHByO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 21:54:14 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 8 May 2012 07:24:11 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q481s7mv6553946
	for <linux-pci@vger.kernel.org>; Tue, 8 May 2012 07:24:08 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q487NMAO024420
	for <linux-pci@vger.kernel.org>; Tue, 8 May 2012 17:23:23 +1000
Date: Tue, 8 May 2012 09:54:06 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] Optimize the resource overlap check
Message-ID: <20120508015406.GA8057@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <1335425575-2023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20120505034730.GA5648@richard>
 <CAErSpo4-fxd8jxZ+o_Jv=eUx20M2mqh9LXpKZ=+uYUShJskPmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAErSpo4-fxd8jxZ+o_Jv=eUx20M2mqh9LXpKZ=+uYUShJskPmQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 07, 2012 at 10:01:40AM -0700, Bjorn Helgaas wrote:
>On Fri, May 4, 2012 at 8:47 PM, Richard Yang <weiyang@linux.vnet.ibm.com> wrote:
>> Bjorn,
>>
>> How do you think of my this version?
>
>Applied to my 'next' branch, thanks.
Thanks :)
>
>> On Thu, Apr 26, 2012 at 03:32:55PM +0800, Wei Yang wrote:
>>>In coalesce_windows() it tries to check whether the res1 and res2 overlap.
>>>This function do four comparisons, which could be done with one
>>>comparisons.
>>>
>>>Also make the resource_overlaps() a common function for others.
>>>
>>>Signed-Off-By: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>---
>>> arch/x86/pci/acpi.c    |   12 +-----------
>>> include/linux/ioport.h |    7 +++++++
>>> 2 files changed, 8 insertions(+), 11 deletions(-)
>>>
>>>diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>>>index 68c3c13..fd3f541 100644
>>>--- a/arch/x86/pci/acpi.c
>>>+++ b/arch/x86/pci/acpi.c
>>>@@ -181,13 +181,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
>>>       return AE_OK;
>>> }
>>>
>>>-static bool resource_contains(struct resource *res, resource_size_t point)
>>>-{
>>>-      if (res->start <= point && point <= res->end)
>>>-              return true;
>>>-      return false;
>>>-}
>>>-
>>> static void coalesce_windows(struct pci_root_info *info, unsigned long type)
>>> {
>>>       int i, j;
>>>@@ -208,10 +201,7 @@ static void coalesce_windows(struct pci_root_info *info, unsigned long type)
>>>                        * our resources no longer match the ACPI _CRS, but
>>>                        * the kernel resource tree doesn't allow overlaps.
>>>                        */
>>>-                      if (resource_contains(res1, res2->start) ||
>>>-                          resource_contains(res1, res2->end) ||
>>>-                          resource_contains(res2, res1->start) ||
>>>-                          resource_contains(res2, res1->end)) {
>>>+                      if (resource_overlaps(res1, res2)) {
>>>                               res1->start = min(res1->start, res2->start);
>>>                               res1->end = max(res1->end, res2->end);
>>>                               dev_info(&info->bridge->dev,
>>>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>>>index e9bb22c..05d2c70 100644
>>>--- a/include/linux/ioport.h
>>>+++ b/include/linux/ioport.h
>>>@@ -198,5 +198,12 @@ extern int
>>> walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>>>               void *arg, int (*func)(unsigned long, unsigned long, void *));
>>>
>>>+static inline bool resource_overlaps(struct resource *r1,
>>>+                                         struct resource *r2)
>>>+{
>>>+       return (r1->start <= r2->end && r1->end >= r2->start);
>>>+}
>>>+
>>>+
>>> #endif /* __ASSEMBLY__ */
>>> #endif        /* _LINUX_IOPORT_H */
>>>--
>>>1.7.4.1
>>
>> --
>> Richard Yang
>> Help you, Help me
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

