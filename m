Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C035AC03
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136299; cv=none; b=L/ADdQjMqo1Dgjd8IXvhLFxOeGfkFJt+6sOwG0gaa9vW0fAAOnSCgWEDWXfKXJURJ5De5fb2sFN/IjCrXDIzbN8hXijMax8m/WcRwsZYvhA1mha+SMqXlH0c/Jk47eVhWv2u12XupMtPFzwO5vq2mikbEKeefL4JWUodYYXSq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136299; c=relaxed/simple;
	bh=QD8HDsLorTOwKnowHDnWqEIpmV2BBsi6qi+p+7WJzwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URnaTMaNpPNKbfkmO5+Stf8Fpbh71tRv/7HOEh1davA8n3+Hlfe1GTHIrmaUqMFkzUyzJDBllnkDj/h/LWOB5vlfOirygegkBpUMYSC9U5R4M83bzvO9bIDL4jThobUtJt7gm3lSmzji5owIGSisgamT4Aw3gzTuoDM20EMB1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=JfA8ehcE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JfA8ehcE"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930c0f9c1b1so240186485a.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786136297; x=1786741097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pd1I5KUa8f+9TeyWUaIVVVrtIGXgdlxuJMrpjZwfZjM=;
        b=JfA8ehcEwSsb0dYI8sUurakn1AqTAntPNwgfuzVABs3SxvLoJDg+nB70MvYyYGkbiy
         uwrgNGIql4pqqbUVlLPpk/IMmeXkmdTJyaSfj4drr/N3rd8XPpb6N+MpUO7/tg0yO1IH
         6Gdvor6UVDnb8mA5OoehjXlAW0HlPrnLHWtjkzp760/XD2kC+XAvmX189MPpxsP6E0pl
         fGdRM9knf2NLbs/LuMfD4oEfAOpB8TIVbbLIyMILirpun82bTVPsqmB7veXzP4077NQ5
         NG0LbTuX+jrUeABCVzLBrNJPaih/6cOaYJTV1TlExe/3scnircSHd+s3lwaQr804WF5i
         82Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136297; x=1786741097;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pd1I5KUa8f+9TeyWUaIVVVrtIGXgdlxuJMrpjZwfZjM=;
        b=HNFdNulhRr5kwJ0X4NC2UWr4rxkHW4exKdQmzVQ4Qc9fPH91Wp8RtOzHGLKMcjmNNp
         dp+T2S/nLgTdofemSTyvuwJ1VyhJYTTR5aZc0sO3Qu/O424yhTvOzFgDeQBa/goI81Pi
         nyx1nBuwYXYvBLcSEegk6En6UoTup3VLvtNL1nMC4Gmfqr2N7rrl27tcE1fcnblsp989
         R5hqn/DQD4JuWVZ5MnVOsRhiRivjmEdQ4jNZ/4Y5hUZRwOhX7FSIXEfLtoakGTmQIXby
         EzP7LxQ/3r9WuzjS8inAtKIy42wFY+1Tj5PcboNZn3jMYhI+qAv5MYYesSGWKDh89XRg
         OaGA==
X-Gm-Message-State: AOJu0YyDOQNxa4CXVatk1HqqtZX3ypfoiXjdc1fvyBKlKtEn7gOTVAVg
	JpFk8JUgcdY2MaBi0n2nLVdsARBeJZ6Hiueuggv9MtZM9SijKUPkMWAm0nYqAkJRzxM=
X-Gm-Gg: AR+sD13Fmsl9TFSyH0zoEEJ7JxyP8S7kGjo8QHumH8XXpgfxaWJY94dOrr+4seQfabp
	zE1G0V9jHMqDXPiVY9f2XVmfJVzvABuSTX0f+iaoQQ4/DrqSsxDGbV/8z8lN3UIX6I3aP2P6ryX
	lb8xoPcwPbHN26Lnx/NfeXyBhs3sFC5ZB/pRDmctdNj3PITS935lXtjLB1D2I2nxKq/6rgZVWAB
	K76GyBMJG2+DS7k2FT2GETodwMiOtEt0gNM0VhLLIaTo/e3+cnKqgGiA7GGud1q7NOSdohomVr3
	cmzIiMU1LOQ/n0ds/YktWpeuarlD6teAJ74hLZZwMx87v0uNagM422Uol88yJH6G+Cg8SWwujm/
	PIEUgip/7aoSdrKoqL5KNqTg/VHv4vH5u3wp0XIQQmPBqADjAInyxXg3miLIF2JUASAF9GpqE4c
	vxAT3zaiz2KE4FnFVhuvgKIkj6mE2WZxvCDm7HGoDiGN0PTLw8hZUP58OFi3b8NoEtZE5euBw=
X-Received: by 2002:a05:620a:12c3:b0:8cf:c106:faca with SMTP id af79cd13be357-93649267a91mr2416475185a.36.1786136297181;
        Fri, 07 Aug 2026 13:58:17 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e09dc07sm233090185a.15.2026.08.07.13.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:58:16 -0700 (PDT)
Message-ID: <a647bd56-7dc8-4fec-9d96-834622054cdf@riscstar.com>
Date: Fri, 7 Aug 2026 15:58:15 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org
References: <20260807194100.455599-1-elder@riscstar.com>
 <20260807194100.455599-2-elder@riscstar.com>
 <20260807195451.C3BAC1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260807195451.C3BAC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 2:54 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing `of_node_put()` in `of_pci_prop_intr_map()` causes a memory leak of interrupt parent device nodes.
> - [High] Missing NULL checks for `kasprintf()` returns in `of_pci_prop_compatible()` leads to a kernel crash via `strlen(NULL)`.
> --
> 
> --- Patch [1]: [PATCH 1/4] PCI: of: drop the reg_num argument to of_pci_set_address() ---
> commit 2224ebd8fd372dc1822f3ceaf7519520a5ca9bdf
> Author: Alex Elder <elder@riscstar.com>
> 
> PCI: of: drop the reg_num argument to of_pci_set_address()
> 
> The reg_num argument passed to of_pci_set_address() is always zero,
> so get rid of it.
> 
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> index 75a358f73e694..505226b876c56 100644
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
> 
> [ ... ]
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing this file I
> noticed a potential resource leak in of_pci_prop_intr_map().
> 
> Does this code leak the interrupt parent device nodes?

There are two device nodes at play here.  The first is
passed in as an argument, np, and although this is referring
to the other one, I analyzed it anyway.

The only place that pointer is used is in the three
of_changeset_add_prop_u32*() calls at the end of the
function.  No reference is taken or dropped to that
node in this function, and presumably that is up to
the caller to manage.

The only caller is of_pci_add_properties(), which similarly
gets the node pointer as an argument, and relies on its
caller for managing its references.  This function's only
caller is of_pci_make_dev_node(), whose purpose is literally
to create a new device node for the purpose of attaching
it to a PCI device node that has none.

So I don't think there is any leak of the np variable passed
in as an argument.


The second device node is pnode, which comes either from
pci_device_to_OF_node() or from pci_bus_to_OF_node().
Neither of those functions takes a reference to the
node pointer they return (assuming it's non-null).

That pointer is assigned to each out_irq[x].np field
before it's passed to of_irq_parse_raw().  The value
returned from of_irq_parse_raw() will either be a null
pointer or will be another device node *with a reference*.

We'll refer to this as *THE* reference.

If this branch is taken:

         if (out_irq->args_count != intsize)
                 goto fail;

The code at fail will properly drop the reference:

fail:
         of_node_put(ipar);

         return rc;

The next block of code gets *another* reference to ipar,
then follows the OF parent pointers up, dropping the
reference taken as each new parent is found.  Once
that loop exits, we still seem to hold THE reference,
though others seem to come and go properly.

Next there is a "big while loop", and it looks to me
like this return statement:

                         pr_debug(" -> got it !\n");
                         return 0;

...does indeed leak a reference to ipar.

There is more to study on this function to be sure this is
right.  But based on this quick look, the Sashiko report
seems right.

==> Can anyone else confirm or refute this?

If nobody tells me this is wrong, I will plan to submit
a bug fix for this.

> 
> drivers/pci/of_property.c:of_pci_prop_intr_map() {
>      ...
>      for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
>          i = pin - 1;
>          out_irq[i].np = pnode;
>          out_irq[i].args_count = 1;
>          out_irq[i].args[0] = pin;
>          ret = of_irq_parse_raw(laddr, &out_irq[i]);
>          if (ret) {
>              out_irq[i].np = NULL;
>              pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
>              continue;
>          }
>          of_property_read_u32(out_irq[i].np, "#address-cells",
>                               &addr_sz[i]);
>      }
>      ...
>      return 0;
> 
> failed:
>      kfree(int_map);
>      return ret;
> }
> 
> of_irq_parse_raw() populates out_irq[i].np with a device node that has an
> incremented reference count.
> 
> Should there be a matching of_node_put() called on these successfully parsed
> nodes before the function returns?
> 
> [Severity: High]
> This is a pre-existing issue, but I also noticed a potential NULL pointer
> dereference in of_pci_prop_compatible().
> 
> Can this crash the kernel if memory allocation fails?

Yes it can.  of_changeset_add_prop_string_array() blindly calls
strlen() on each array string provided.

I will create a bug fix for this issue as well.

					-Alex

> 
> drivers/pci/of_property.c:of_pci_prop_compatible() {
>      ...
>      compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
>          kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
>      compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
>          kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
>      compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
>          kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
> 
>      ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
>                                               compat_strs, PROP_COMPAT_NUM);
>      ...
> }
> 
> If kasprintf() returns NULL, the compat_strs array will contain NULL pointers.
> 
> When this unvalidated array is passed to
> of_changeset_add_prop_string_array(), could it lead to a kernel crash when
> the string array is processed and strlen() is called on a NULL element?
> 

