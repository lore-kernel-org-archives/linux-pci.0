Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51897 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab2AGDqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 22:46:03 -0500
Received: by ggdk6 with SMTP id k6so994975ggd.19
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2012 19:46:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120106134915.705f5b47@jbarnes-desktop>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120106134915.705f5b47@jbarnes-desktop>
Date: Fri, 6 Jan 2012 19:46:02 -0800
Message-ID: <CAE9FiQXKVgkHg9fqXHvs7umnXkQ1Hmxudfy84jdy1n_Mo5D9Cg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 6, 2012 at 1:49 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> Linus, can you please check this out too?  It seems like we're just
> piling on heuristics here with code that's already pretty unreadable...

related patches could be found:
http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci

>
> In general I like the idea of improving the resource reassignment code,
> even with more heuristics, but I think we need some refactoring to make
> them easier to follow.  Right now we re-use all this logic even for
> simple device which seems like overkill.
>
> Overall in looking at all this again I regret not asking for more
> cleanups before it went in:
>  1) resource_list_x?  really?
>  2) why aren't we using list_head?

will check that later, and could address that in another patch.

>  3) realloc/fail_head don't communicate much either
>
> Other comments below.
>
> On Wed,  7 Dec 2011 00:53:01 -0800
> Yinghai Lu <yinghai@kernel.org> wrote:
>
>> Found reassign can not find right range for one resource. even total range is enough.
>>
>> bridge b1:02.0 will need 2M+3M
>> bridge b1:03.0 will need 2M+3M
>>
>> so bridge b0:00.0 will get assigned: 4M : [f8000000-f83fffff]
>>    later is reassigned to 10M : [f8000000-f9ffffff]
>>
>> b1:02.0 is assigned to 2M : [f8000000-f81fffff]
>> b1:03.0 is assigned to 2M : [f8200000-f83fffff]
>>
>> after that b1:03.0 get chance to be reassigned to [f8200000-f86fffff]
>> but b1:02.0 will not have chance to expand, because b1:03.0 is using in middle one.
>>
>> [  187.911401] pci 0000:b1:02.0: bridge window [mem 0x00100000-0x002fffff] to [bus b2-b2] add_size 300000
>> [  187.920764] pci 0000:b1:03.0: bridge window [mem 0x00100000-0x002fffff] to [bus b3-b3] add_size 300000
>> [  187.930129] pci 0000:b1:02.0: [mem 0x00100000-0x002fffff] get_res_add_size  add_size 300000
>> [  187.938500] pci 0000:b1:03.0: [mem 0x00100000-0x002fffff] get_res_add_size  add_size 300000
>> [  187.946857] pci 0000:b0:00.0: bridge window [mem 0x00100000-0x004fffff] to [bus b1-b3] add_size 600000
>> [  187.956206] pci 0000:b0:00.0: BAR 14: assigned [mem 0xf8000000-0xf83fffff]
>> [  187.963102] pci 0000:b0:00.0: BAR 15: assigned [mem 0xf5000000-0xf51fffff pref]
>> [  187.970434] pci 0000:b0:00.0: BAR 14: reassigned [mem 0xf8000000-0xf89fffff]
>> [  187.977497] pci 0000:b1:02.0: BAR 14: assigned [mem 0xf8000000-0xf81fffff]
>> [  187.984383] pci 0000:b1:02.0: BAR 15: assigned [mem 0xf5000000-0xf50fffff pref]
>> [  187.991695] pci 0000:b1:03.0: BAR 14: assigned [mem 0xf8200000-0xf83fffff]
>> [  187.998576] pci 0000:b1:03.0: BAR 15: assigned [mem 0xf5100000-0xf51fffff pref]
>> [  188.005888] pci 0000:b1:03.0: BAR 14: reassigned [mem 0xf8200000-0xf86fffff]
>> [  188.012939] pci 0000:b1:02.0: BAR 14: can't assign mem (size 0x200000)
>> [  188.019471] pci 0000:b1:02.0: failed to add 300000 to res=[mem 0xf8000000-0xf81fffff]
>> [  188.027326] pci 0000:b2:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
>> [  188.034071] pci 0000:b2:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
>> [  188.040795] pci 0000:b2:00.0: BAR 2: assigned [mem 0xf8000000-0xf80fffff 64bit]
>> [  188.048119] pci 0000:b2:00.0: BAR 2: set to [mem 0xf8000000-0xf80fffff 64bit] (PCI address [0xf8000000-0xf80fffff])
>> [  188.058550] pci 0000:b2:00.0: BAR 6: assigned [mem 0xf5000000-0xf50fffff pref]
>> [  188.065802] pci 0000:b2:00.0: BAR 0: assigned [mem 0xf8100000-0xf8103fff 64bit]
>> [  188.073125] pci 0000:b2:00.0: BAR 0: set to [mem 0xf8100000-0xf8103fff 64bit] (PCI address [0xf8100000-0xf8103fff])
>> [  188.083596] pci 0000:b2:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
>> [  188.090310] pci 0000:b2:00.0: BAR 9: can't assign mem (size 0x300000)
>> [  188.096773] pci 0000:b2:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
>> [  188.103479] pci 0000:b2:00.0: BAR 7: assigned [mem 0xf8104000-0xf810ffff 64bit]
>> [  188.110801] pci 0000:b2:00.0: BAR 7: set to [mem 0xf8104000-0xf810ffff 64bit] (PCI address [0xf8104000-0xf810ffff])
>> [  188.121256] pci 0000:b1:02.0: PCI bridge to [bus b2-b2]
>> [  188.126512] pci 0000:b1:02.0:   bridge window [mem 0xf8000000-0xf81fffff]
>> [  188.133328] pci 0000:b1:02.0:   bridge window [mem 0xf5000000-0xf50fffff pref]
>> [  188.140608] pci 0000:b3:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
>> [  188.147341] pci 0000:b3:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
>> [  188.154076] pci 0000:b3:00.0: BAR 2: assigned [mem 0xf8200000-0xf82fffff 64bit]
>> [  188.161417] pci 0000:b3:00.0: BAR 2: set to [mem 0xf8200000-0xf82fffff 64bit] (PCI address [0xf8200000-0xf82fffff])
>> [  188.171865] pci 0000:b3:00.0: BAR 6: assigned [mem 0xf5100000-0xf51fffff pref]
>> [  188.179090] pci 0000:b3:00.0: BAR 0: assigned [mem 0xf8300000-0xf8303fff 64bit]
>> [  188.186431] pci 0000:b3:00.0: BAR 0: set to [mem 0xf8300000-0xf8303fff 64bit] (PCI address [0xf8300000-0xf8303fff])
>> [  188.196884] pci 0000:b3:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
>> [  188.203591] pci 0000:b3:00.0: BAR 9: assigned [mem 0xf8400000-0xf86fffff 64bit]
>> [  188.210909] pci 0000:b3:00.0: BAR 9: set to [mem 0xf8400000-0xf86fffff 64bit] (PCI address [0xf8400000-0xf86fffff])
>> [  188.221379] pci 0000:b3:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
>> [  188.228089] pci 0000:b3:00.0: BAR 7: assigned [mem 0xf8304000-0xf830ffff 64bit]
>> [  188.235407] pci 0000:b3:00.0: BAR 7: set to [mem 0xf8304000-0xf830ffff 64bit] (PCI address [0xf8304000-0xf830ffff])
>> [  188.245843] pci 0000:b1:03.0: PCI bridge to [bus b3-b3]
>> [  188.251107] pci 0000:b1:03.0:   bridge window [mem 0xf8200000-0xf86fffff]
>> [  188.257922] pci 0000:b1:03.0:   bridge window [mem 0xf5100000-0xf51fffff pref]
>> [  188.265180] pci 0000:b0:00.0: PCI bridge to [bus b1-b3]
>> [  188.270443] pci 0000:b0:00.0:   bridge window [mem 0xf8000000-0xf89fffff]
>> [  188.277250] pci 0000:b0:00.0:   bridge window [mem 0xf5000000-0xf51fffff pref]
>> [  188.284512] pcieport 0000:80:02.2: PCI bridge to [bus b0-bf]
>> [  188.290184] pcieport 0000:80:02.2:   bridge window [io  0xa000-0xbfff]
>> [  188.296735] pcieport 0000:80:02.2:   bridge window [mem 0xf8000000-0xf8ffffff]
>> [  188.303963] pcieport 0000:80:02.2:   bridge window [mem 0xf5000000-0xf5ffffff 64bit pref]
>>
>> b2:00.0 BAR 9 has not get assigned...
>>
>> root cause:
>> b1:02.0 can not be added more range, because b1:03.0 is just after it.
>> not space between required ranges.
>>
>> Solution:
>> Try to assign required + optional all together at first, and if it fails, go with required then reassign path.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>
>> ---
>>  drivers/pci/setup-bus.c |  113 +++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 97 insertions(+), 16 deletions(-)
>>
>> Index: linux-2.6/drivers/pci/setup-bus.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/setup-bus.c
>> +++ linux-2.6/drivers/pci/setup-bus.c
>> @@ -64,7 +64,7 @@ void pci_realloc(void)
>>   * @add_size:        additional size to be optionally added
>>   *              to the resource
>>   */
>> -static void add_to_list(struct resource_list_x *head,
>> +static int add_to_list(struct resource_list_x *head,
>>                struct pci_dev *dev, struct resource *res,
>>                resource_size_t add_size, resource_size_t min_align)
>>  {
>> @@ -75,7 +75,7 @@ static void add_to_list(struct resource_
>>       tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
>>       if (!tmp) {
>>               pr_warning("add_to_list: kmalloc() failed!\n");
>> -             return;
>> +             return -ENOMEM;
>>       }
>>
>>       tmp->next = ln;
>> @@ -87,6 +87,8 @@ static void add_to_list(struct resource_
>>       tmp->add_size = add_size;
>>       tmp->min_align = min_align;
>>       list->next = tmp;
>> +
>> +     return 0;
>>  }
>
> This looks like a separate bug fix; can you separate it out?  I assume
> you ran into it at least once as you were adding more recursion and
> occasionally not exiting it quickly. :)

ok, will separate that to another patch.

>
> At least a couple of the callers could use the return value...
>
>> @@ -221,6 +259,63 @@ static void __assign_resources_sorted(st
>>                                struct resource_list_x *realloc_head,
>>                                struct resource_list_x *fail_head)
>>  {
>> +     /*
>> +      * Should not assign requested resources at first.
>> +      *   they could be adjacent, so later reassign can not reallocate
>> +      *   them one by one in parent resource window.
>> +      * Try to assign requested + add_size at begining
>> +      *  if could do that, could get out early.
>> +      *  if could not do that, we still try to assign requested at first,
>> +      *    then try to reassign add_size for some resources.
>> +      */
>> +     struct resource_list_x save_head, local_fail_head, *list;
>> +     struct resource_list *l;
>> +
>> +     if (!realloc_head)
>> +             goto requested_and_reassign;
>
> Should this also check for realloc_head existing but being empty?  Or
> do we never get that case by the time we get here?

yes, will add that check.

>
>> +     /* Save original start, end, flags etc */
>> +     save_head.next = NULL;
>> +     for (l = head->next; l; l = l->next)
>> +             if (add_to_list(&save_head, l->dev, l->res, 0, 0)) {
>> +                     free_list(resource_list_x, &save_head);
>> +                     goto requested_and_reassign;
>> +             }
>
> Maybe a small helper: copy_resource_list_x(struct resource_list_x *to,
> struct resource_list *from)?  (Yay more helpful 'x' usage.)  Generally
> a few small helpers would make this function a lot easier to follow...

ok, will add that helper.

>
>> +
>> +     /* Update res in head list with add_size in realloc_head list */
>> +     for (l = head->next; l; l = l->next)
>> +             l->res->end += get_res_add_size(realloc_head, l->res);
>
> These loops might benefit from a for_each_resource_list macro (we have
> lots of similar onese elsewhere in the kernel).
>
> I also like the new get_res_add_size function better, but you moved it
> and changed it at the same time and lumped it into this patch, so it
> should be broken out.

ok, will break out get_res_add_size moving to another patch.

>
>> +
>> +     /* Try updated head list with add_size added */
>> +     local_fail_head.next = NULL;
>> +     assign_requested_resources_sorted(head, &local_fail_head);
>> +
>> +     /* all assigned with add_size ? */
>> +     if (!local_fail_head.next) {
>
> list_empty would be slightly more readable.

later after change resource_list_x to regular list...

Thanks

Yinghai
