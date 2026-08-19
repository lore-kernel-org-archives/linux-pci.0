Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31A3C5827;
	Wed, 19 Aug 2026 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120932; cv=none; b=MzYb6VAQrNosrR/Al9mpA2YOtTynPogW+e2Atd7IWzWELqj6o94cJyR3XnJfSXzYyrllnnTzShSfBDhVmXD3/mAuuR+eDLwsZbqxErZEJCCPQuNk/p96NcyWJCY2kcCEzsc/7KBOGC1+Wn76gWNoIBT8yPgwGNobqu/jNjuKGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120932; c=relaxed/simple;
	bh=QKl/Mib716SGXXL7hPnUAxXAzqpJEkp97VdhZtF+TSA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=CcFSe8jbDVBfewst1kTGWVOngwKIuldqyc4I6okWnhoLhMRKEWbRQEFqrNLR3CLBNohyZy9UEsTOTKayfTI4TS16au1ORw0hEdeVMJgzkQBVWMSfbM8/kMG5264DEy20Vx6v2eOfd+Oi0XFRjjCLLG0VpGSVji0ruCTZiFOZ3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ox8VLaXK; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PCfQDLKA; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ox8VLaXK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PCfQDLKA"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hPxV65WtWzMlMk;
	Wed, 19 Aug 2026 08:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787120926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPyb9KQif3Zg91CB6/+ih1ipQwmInFoe50ChCFX09/Q=;
	b=ox8VLaXKw9B+QG6SWj2TUPCJHsr4lzASInOuS/IKc5Q8B4H69hIgxiBbAABrcO/04zMdOw
	TOk4JlrrI7CWNrmturPOsUhThB5/Dsar5UKFpt3vOOrHsI9dzib1vyAlmqh6Se3C+zAfKb
	7NYtfzOql/aq75m3udjcSnA76lnyjrFZFA2e0NmJEvzLqmEkGQzO3GWryl1r1Td0qKcuOx
	utup1G3ZntGbUHfca0AYipK1dyfyk5+elkpPxcXPXsLb1yuwYZDDSBCSSYAxaixw6gb7h7
	tQ+dSUtQLclmxcenZgwcfGkPA/IiF1sT4YnasNQqgKO5wBclpolR8Xyt+J+ekQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PCfQDLKA;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Content-Type: multipart/mixed; boundary="------------7SLIZBiZkPk4BgbjcjhUZWCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787120925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPyb9KQif3Zg91CB6/+ih1ipQwmInFoe50ChCFX09/Q=;
	b=PCfQDLKA6FzSMR0f/G4LIWJk3MGJtOFLegbcr9/8FRFPFdQO7mru+S8NUhrrcxrp1+wcG+
	Cr2Rd58orXzf5NfPaJoYzAN++3GqyIGnOLGv/VrEaZey6sS42Fp/2R+x4N+jgEd0k8ZTkc
	DX5+r5P5oTL2Zzu4LC7+V1KxqSb8VXQJRTzw/DyAYYFN4Ffq7nNv4eLy+xYO+xRbw2K5gu
	EnuGi9+vhVkw4Kw4WbAqj3VB3a6qaqFILfY3vbMFDBQTyuB8vxtuJRk5eQRXW00A/3zhNT
	qs2v8r6trg7zrM8T/bZTecd045yoj9jhk7CrTLAXV3L+PLi3cNUuaqHLgaQq9A==
Message-ID: <0e5dae39-3ded-4b24-b3aa-7707983ec243@mailbox.org>
Date: Wed, 19 Aug 2026 08:28:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in
 rcar_gen4_pcie_ep_deinit()
To: Koichiro Den <den@valinux.co.jp>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
 <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
 <CAMuHMdUAph2fbR94k8RDaAeVH=OTKWAWe1dJne9D-YbQQrYHsA@mail.gmail.com>
 <zi6an774rs4zsvz4rgvskvchlcz3ontuih7ztime673pw55axf@updaznhtexix>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <zi6an774rs4zsvz4rgvskvchlcz3ontuih7ztime673pw55axf@updaznhtexix>
X-MBO-RS-ID: 30e8855901f68b3dd32
X-MBO-RS-META: 4d4e9fadum6i6najz1u7tztd5heyn68m
X-Rspamd-Queue-Id: 4hPxV65WtWzMlMk

This is a multi-part message in MIME format.
--------------7SLIZBiZkPk4BgbjcjhUZWCm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 5:09 PM, Koichiro Den wrote:

Hello Den-san,

> I see, CPG_MOD 624. Thanks! Then I am not sure the original writel() is actually
> unclocked. It runs before pm_runtime_put(), so runtime PM still keeps that clock
> enabled. If "unclocked" means ref clock instead, the new writel() also runs
> before clk_bulk_prepare_enable(). Probably I'm missing something again. I would
> appreciate it if you could shed light on this.

This is clearly my error, the commit message is poorly written.

The rcar_gen4_add_dw_pcie_ep() contains two calls which can fail, 
dw_pcie_ep_init() and dw_pcie_ep_init_registers().

The first one, dw_pcie_ep_init(), internally calls .pre_init callback, 
which is implemented in rcar_gen4_pcie_ep_pre_init() on R-Car Gen4 .

The rcar_gen4_pcie_ep_pre_init() internally calls 
rcar_gen4_pcie_common_init(), which may succeed or fail. At this point, 
two possibilities can happen, the fail one is of interest:
- If rcar_gen4_pcie_common_init() succeeds , then 
clk_bulk_prepare_enable() in rcar_gen4_pcie_common_init() did enable all 
dw->core_clks and those clock are kept enabled on exit from 
rcar_gen4_pcie_common_init() . The return value from 
rcar_gen4_pcie_common_init() is 0. OK.
- If rcar_gen4_pcie_common_init() failed, then 
clk_bulk_disable_unprepare() is called in rcar_gen4_pcie_common_init() 
fail path and dw->core_clks clock are disabled. Return value from 
rcar_gen4_pcie_common_init() is non-zero. NG.

Back in rcar_gen4_pcie_ep_pre_init():
- If rcar_gen4_pcie_ep_pre_init() succeeded , then write PCIEDMAINTSTSEN 
and enable edma_int , and exit with return value 0, OK.
- If rcar_gen4_pcie_common_init() failed, then immediately exit with 
return value non-zero. Do not write PCIEDMAINTSTSEN and do not enable 
the edma_interrupts, do depend on previously set content of 
PCIEDMAINTSTSEN register, which was zeroed out at the beginning of this 
function instead. NG.

Finally, back in rcar_gen4_add_dw_pcie_ep():
- If dw_pcie_ep_init() failed, then dw->core_clks have to be disabled at 
this point (*), and PCIEDMAINTSTSEN register is 0, therefore, do not 
call rcar_gen4_pcie_ep_deinit() which writes PCIEDMAINTSTSEN register to 
0 (again) and calls rcar_gen4_pcie_common_deinit(), directly call 
rcar_gen4_pcie_common_deinit() (**).

But as I wrote this part, I realized the (*) is not true, and 
rcar_gen4_pcie_common_deinit() is not the correct function to call in 
case dw_pcie_ep_init() fails.

I think we might need this kind of a patch:

"
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c 
b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de8ee3db43601..a5801a74dec67 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1553,7 +1553,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
                                ep->page_size);
         if (ret < 0) {
                 dev_err(dev, "Failed to initialize address space\n");
-               return ret;
+               goto err_deinit;
         }

         ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
@@ -1568,6 +1568,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)

  err_exit_epc_mem:
         pci_epc_mem_exit(epc);
+err_deinit:
+       if (ep->ops->pre_deinit)
+               ep->ops->pre_deinit(ep);

         return ret;
  }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h 
b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae9409240..733d8b6ad6d2b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -475,6 +475,7 @@ struct dw_pcie_rp {

  struct dw_pcie_ep_ops {
         int     (*pre_init)(struct dw_pcie_ep *ep);
+       void    (*pre_deinit)(struct dw_pcie_ep *ep);
         int     (*init)(struct dw_pcie_ep *ep);
         int     (*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
                              unsigned int type, u16 interrupt_num);
"

Then implement .pre_deinit callback for R-Car Gen4 such, that it would 
assert reset and stop the dw->core_clks by calling 
rcar_gen4_pcie_common_deinit(). Then we are sure (*) is true.

Finally, if dw_pcie_ep_init() call in rcar_gen4_add_dw_pcie_ep() fails, 
then with the aforementioned deinit implementation, I think it will be 
possible to simply do the following to cover (**).

ret = dw_pcie_ep_init(ep);
if (ret)
   return ret;

(I am also attaching the entire example as a diff, compile tested only 
thus far)

What do you think ?

> P.S. I also ran two error injection experiments on an S4 Spider. This is also
> related to question #2 in my previous comment.
> 
> - When I injected a failure inside common_init(), its error path unwound the
>    bulk clocks itself. Calling common_deinit() afterwards triggered "already
>    disabled/unprepared" warnings.

I think this ought to be addressed by the pre_deinit above.

> - When I injected a failure after pre_init() had succeeded, PCIEDMAINTSTSEN read
>    back as 0xffff both before and after common_deinit().

I think that with the aforementioned pre_deinit implementation, in case 
pre_init succeeded and a failure occurred in dw_pcie_ep_init_registers() 
instead, the PCIEDMAINTSTSEN will be cleared in 
rcar_gen4_pcie_ep_deinit() correctly.

Does that cover this concern or is there another fail path which I missed ?

> So I think clean-up needs to know whether pre_init() completed, rather than
> always calling common_deinit(). Something like this (field declaration omitted):
> 
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -487,17 +487,24 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
>          struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>          int ret;
> 
>          ret = rcar_gen4_pcie_common_init(rcar);
>          if (ret)
>                  return ret;
> 
>          writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> +       rcar->ep_pre_init_done = true;
> 
>          return 0;
>   }
> 
>   static void rcar_gen4_pcie_ep_deinit(struct rcar_gen4_pcie *rcar)
>   {
> +       if (!rcar->ep_pre_init_done)
> +               return;
> +
> +       rcar->ep_pre_init_done = false;
>          writel(0, rcar->base + PCIEDMAINTSTSEN);
>          rcar_gen4_pcie_common_deinit(rcar);
>   }
> 
> I may be missing something again, so please just take it with a pinch of salt.
Thank you for your feedback, it allowed me to find an error in my train 
of thoughts, it is very much appreciated. I hope we can also find a good 
solution.

Thank you for your help !

-- 
Best regards,
Marek Vasut
--------------7SLIZBiZkPk4BgbjcjhUZWCm
Content-Type: text/x-patch; charset=UTF-8; name="0001-FIXME-pre_deinit.patch"
Content-Disposition: attachment; filename="0001-FIXME-pre_deinit.patch"
Content-Transfer-Encoding: base64

RnJvbSA2YTc0NzY4N2RjYTQ0NjdhOWMzZWVhMmMyYWM1NzdlMDE3ZmExYmEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNh
c0BtYWlsYm94Lm9yZz4KRGF0ZTogV2VkLCAxOSBBdWcgMjAyNiAwODoxMDoxNSArMDIwMApT
dWJqZWN0OiBbUEFUQ0hdIEZJWE1FOiBwcmVfZGVpbml0CgpTaWduZWQtb2ZmLWJ5OiBNYXJl
ayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz4KLS0tCiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyB8ICA1ICsrKystCiBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCAgICB8ICAxICsK
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMgICAgIHwgMTMg
KysrKysrKysrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWVwLmMKaW5kZXggZGU4ZWUzZGI0MzYwMS4uYTU4MDFhNzRkZWM2NyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVw
LmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVw
LmMKQEAgLTE1NTMsNyArMTU1Myw3IEBAIGludCBkd19wY2llX2VwX2luaXQoc3RydWN0IGR3
X3BjaWVfZXAgKmVwKQogCQkJICAgICAgIGVwLT5wYWdlX3NpemUpOwogCWlmIChyZXQgPCAw
KSB7CiAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGluaXRpYWxpemUgYWRkcmVzcyBzcGFj
ZVxuIik7Ci0JCXJldHVybiByZXQ7CisJCWdvdG8gZXJyX2RlaW5pdDsKIAl9CiAKIAllcC0+
bXNpX21lbSA9IHBjaV9lcGNfbWVtX2FsbG9jX2FkZHIoZXBjLCAmZXAtPm1zaV9tZW1fcGh5
cywKQEAgLTE1NjgsNiArMTU2OCw5IEBAIGludCBkd19wY2llX2VwX2luaXQoc3RydWN0IGR3
X3BjaWVfZXAgKmVwKQogCiBlcnJfZXhpdF9lcGNfbWVtOgogCXBjaV9lcGNfbWVtX2V4aXQo
ZXBjKTsKK2Vycl9kZWluaXQ6CisJaWYgKGVwLT5vcHMtPnByZV9kZWluaXQpCisJCWVwLT5v
cHMtPnByZV9kZWluaXQoZXApOwogCiAJcmV0dXJuIHJldDsKIH0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgKaW5kZXggMDczNWFlOTQwOTI0
MC4uNzMzZDhiNmFkNmQyYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLmgKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmgKQEAgLTQ3NSw2ICs0NzUsNyBAQCBzdHJ1Y3QgZHdfcGNpZV9y
cCB7CiAKIHN0cnVjdCBkd19wY2llX2VwX29wcyB7CiAJaW50CSgqcHJlX2luaXQpKHN0cnVj
dCBkd19wY2llX2VwICplcCk7CisJdm9pZAkoKnByZV9kZWluaXQpKHN0cnVjdCBkd19wY2ll
X2VwICplcCk7CiAJaW50CSgqaW5pdCkoc3RydWN0IGR3X3BjaWVfZXAgKmVwKTsKIAlpbnQJ
KCpyYWlzZV9pcnEpKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywKIAkJCSAg
ICAgdW5zaWduZWQgaW50IHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jCmluZGV4IGI0NzI4MWIzMGRi
OTYuLjVmZWUyZTNlMmM5MWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtcmNhci1nZW40LmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1yY2FyLWdlbjQuYwpAQCAtNDk4LDYgKzQ5OCwxNCBAQCBzdGF0aWMgaW50IHJjYXJf
Z2VuNF9wY2llX2VwX3ByZV9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkKIAlyZXR1cm4g
MDsKIH0KIAorc3RhdGljIHZvaWQgcmNhcl9nZW40X3BjaWVfZXBfcHJlX2RlaW5pdChzdHJ1
Y3QgZHdfcGNpZV9lcCAqZXApCit7CisJc3RydWN0IGR3X3BjaWUgKmR3ID0gdG9fZHdfcGNp
ZV9mcm9tX2VwKGVwKTsKKwlzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIgPSB0b19yY2Fy
X2dlbjRfcGNpZShkdyk7CisKKwlyY2FyX2dlbjRfcGNpZV9jb21tb25fZGVpbml0KHJjYXIp
OworfQorCiBzdGF0aWMgdm9pZCByY2FyX2dlbjRfcGNpZV9lcF9kZWluaXQoc3RydWN0IHJj
YXJfZ2VuNF9wY2llICpyY2FyKQogewogCXdyaXRlbCgwLCByY2FyLT5iYXNlICsgUENJRURN
QUlOVFNUU0VOKTsKQEAgLTU1NCw2ICs1NjIsNyBAQCBzdGF0aWMgdW5zaWduZWQgaW50IHJj
YXJfZ2VuNF9wY2llX2VwX2dldF9kYmkyX29mZnNldChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAs
CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9lcF9vcHMgcGNpZV9lcF9vcHMgPSB7
CiAJLnByZV9pbml0ID0gcmNhcl9nZW40X3BjaWVfZXBfcHJlX2luaXQsCisJLnByZV9kZWlu
aXQgPSByY2FyX2dlbjRfcGNpZV9lcF9wcmVfZGVpbml0LAogCS5yYWlzZV9pcnEgPSByY2Fy
X2dlbjRfcGNpZV9lcF9yYWlzZV9pcnEsCiAJLmdldF9mZWF0dXJlcyA9IHJjYXJfZ2VuNF9w
Y2llX2VwX2dldF9mZWF0dXJlcywKIAkuZ2V0X2RiaV9vZmZzZXQgPSByY2FyX2dlbjRfcGNp
ZV9lcF9nZXRfZGJpX29mZnNldCwKQEAgLTU3MiwxMCArNTgxLDggQEAgc3RhdGljIGludCBy
Y2FyX2dlbjRfYWRkX2R3X3BjaWVfZXAoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKQog
CWVwLT5vcHMgPSAmcGNpZV9lcF9vcHM7CiAKIAlyZXQgPSBkd19wY2llX2VwX2luaXQoZXAp
OwotCWlmIChyZXQpIHsKLQkJcmNhcl9nZW40X3BjaWVfY29tbW9uX2RlaW5pdChyY2FyKTsK
KwlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwotCX0KIAogCXJldCA9IGR3X3BjaWVfZXBfaW5p
dF9yZWdpc3RlcnMoZXApOwogCWlmIChyZXQpIHsKLS0gCjIuNTMuMAoK

--------------7SLIZBiZkPk4BgbjcjhUZWCm--
