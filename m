Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64768 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab2EGRCD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 13:02:03 -0400
Received: by lbbgm6 with SMTP id gm6so3586628lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 07 May 2012 10:02:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120505034730.GA5648@richard>
References: <1335425575-2023-1-git-send-email-weiyang@linux.vnet.ibm.com> <20120505034730.GA5648@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 May 2012 10:01:40 -0700
Message-ID: <CAErSpo4-fxd8jxZ+o_Jv=eUx20M2mqh9LXpKZ=+uYUShJskPmQ@mail.gmail.com>
Subject: Re: [PATCH] Optimize the resource overlap check
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 4, 2012 at 8:47 PM, Richard Yang <weiyang@linux.vnet.ibm.com> wrote:
> Bjorn,
>
> How do you think of my this version?

Applied to my 'next' branch, thanks.

> On Thu, Apr 26, 2012 at 03:32:55PM +0800, Wei Yang wrote:
>>In coalesce_windows() it tries to check whether the res1 and res2 overlap.
>>This function do four comparisons, which could be done with one
>>comparisons.
>>
>>Also make the resource_overlaps() a common function for others.
>>
>>Signed-Off-By: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/x86/pci/acpi.c    |   12 +-----------
>> include/linux/ioport.h |    7 +++++++
>> 2 files changed, 8 insertions(+), 11 deletions(-)
>>
>>diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>>index 68c3c13..fd3f541 100644
>>--- a/arch/x86/pci/acpi.c
>>+++ b/arch/x86/pci/acpi.c
>>@@ -181,13 +181,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
>>       return AE_OK;
>> }
>>
>>-static bool resource_contains(struct resource *res, resource_size_t point)
>>-{
>>-      if (res->start <= point && point <= res->end)
>>-              return true;
>>-      return false;
>>-}
>>-
>> static void coalesce_windows(struct pci_root_info *info, unsigned long type)
>> {
>>       int i, j;
>>@@ -208,10 +201,7 @@ static void coalesce_windows(struct pci_root_info *info, unsigned long type)
>>                        * our resources no longer match the ACPI _CRS, but
>>                        * the kernel resource tree doesn't allow overlaps.
>>                        */
>>-                      if (resource_contains(res1, res2->start) ||
>>-                          resource_contains(res1, res2->end) ||
>>-                          resource_contains(res2, res1->start) ||
>>-                          resource_contains(res2, res1->end)) {
>>+                      if (resource_overlaps(res1, res2)) {
>>                               res1->start = min(res1->start, res2->start);
>>                               res1->end = max(res1->end, res2->end);
>>                               dev_info(&info->bridge->dev,
>>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>>index e9bb22c..05d2c70 100644
>>--- a/include/linux/ioport.h
>>+++ b/include/linux/ioport.h
>>@@ -198,5 +198,12 @@ extern int
>> walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>>               void *arg, int (*func)(unsigned long, unsigned long, void *));
>>
>>+static inline bool resource_overlaps(struct resource *r1,
>>+                                         struct resource *r2)
>>+{
>>+       return (r1->start <= r2->end && r1->end >= r2->start);
>>+}
>>+
>>+
>> #endif /* __ASSEMBLY__ */
>> #endif        /* _LINUX_IOPORT_H */
>>--
>>1.7.4.1
>
> --
> Richard Yang
> Help you, Help me
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
