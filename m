Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836518;
	b=vJPo07DKV9hQCAz78jBXej4lRBVk1MObVCLIPAvCJSw7b3KOLoQfkEZvZru1fsch9HWn
	 UuBWhldwuDK6tbwFuplDv9vOsqWntxOXULI+1CVxroAIsshRGssSEWJ35LOKrBUPzAnz4
	 QyQNzBMwoQn8+x9hN+xTY9c/EH3yQzYfv1+o7GQeHUShCSyo1MaXy1b3BFL1WI+ko1HgV
	 vibsVEiMUi36EZ1BFcBrrD9NYPrTVW7GVcSxdYHClAJWSNJXFnsS+oFC6YZzf+9GIZFkM
	 a2vf6rPTmq9CtkuZ9EwX1MXXMVJt7bQN/0lt6Rx6k/6jU1A9vc+/+tnSKv1fqYJqQog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836518;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jyOh8dtZhFwam1bQ7aHKxAcq0MWjfq11be7F4YuWx0E=;
	b=3OA6iznsddJGLmN+a/kI2lkUeaos1qX+AVnsND44KtQPgp0MvdwovkqY166+YZtr8uSo
	 D0J5e+frZBtFN5OTPkIPKHTuLomjl1wIc7D6YO8EIRODKGBDe3fXikRQ1SMObzWR6/7VG
	 fXzcVP3G5nhcp96FJrGArQGXKzr6kOj7YVvjmlkxNKA6wZiQsoxQhrrukvjFtgy2ENkZm
	 h0JCwHCJ+PwmnXsrSKIH2J1CE9GsHcMPKuWRvHlbIa5CBU69chrxuzxIF7KWa7GM1wfQX
	 7f/o8zu4t7vrz76Y0S2x5x8Wj3J79EpU36PXfh9fYosRAazRxsPFwiC46OoZGBkEXpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=nIvW5eIH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HueqMRZi;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0948E606EEBA
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0948E606EEBA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=nIvW5eIH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HueqMRZi
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 724BF14001DA
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:55:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 18:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793836516;
	 x=1793922916; bh=jyOh8dtZhFwam1bQ7aHKxAcq0MWjfq11be7F4YuWx0E=; b=
	nIvW5eIHOZhzwNl5EFOzhFc6zjWytDOSASJvlKK3+3mIwepFYaqTcVy0KHg8YssM
	rUd9pwz4VWi0JAxSMvsK5PlZNAngoOUJ+bBS4Jgrjy1yK+NgksH8cUOnJmXtVoBw
	H3bjxo9k8Mqs7UIB9q/htMH23QUrTXHSSUtkenQ3+EDlUZwQWPJ1GiIKFWNufWZR
	6wdFsn3LiH5X0uThxURwJGo5L+1hb3rd28WHgxCCdP5z6FhrRYpnbG9Q1xTrQGZW
	dZT1Njjt4gq1r4VYuA7vccZ32HC3fKFLmr+lPIufY8/gqM3RwUzCYdk3e9d1ZTK9
	JvfgxfuJBiQUFZ4dl5QjmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793836516; x=
	1793922916; bh=jyOh8dtZhFwam1bQ7aHKxAcq0MWjfq11be7F4YuWx0E=; b=H
	ueqMRZixSxWFjZu5EugKdjetrleb2x3HDz75Pc4BinYEr6CG+jxKygGzx6FRz2n9
	/yvQHxPoZr4j4SVbg00xz0VVz2K03X1vN4KcdUPyVtX8/84gGDbcneSZp9okFYG5
	dwtOXxQjH82CWSmwpbJsrgpSbZ0nxvFvcZ0FpVGDNciDhC0Xum7KmNGwLkR0iTrv
	rsnr9ReU5H+fHUsQAjDw6nb//qfsFnoBkNeBr1WL2PxACIFI3mbyusj80S5jjnrP
	7Qh+1qnx0XV79Lpsy1GrWk/aVtRsQ6fumWWmQkS5ybt6oopq1KoKGw4g5bQacKri
	EX7YN10kBZ4N4gA3fo/bA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793836516; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WpZyuQZnCwqU4zV/2R2HemE0s1bjDs1yELEG67kax2yyK5g
	pJQOY1iPu3YIBMmj5Y46gCaFsZmjuWdEZ5ExrgM4O76fiBnALzDuAMc0HpbHdmjL
	dsTwi/4+t9ZyvRf8zgi3U6Z6mmA5Iho60cRQjnYFhYd+MPRBfSpNRLTa5+JdMGk6
	jIiqxums0bNlgaSYhBzXJpTgTfwqL5fmcs5YOin7wc/D2WuTb8goGIUhZeJX3PYN
	Hf3+Vx5+QaSo/1dSsHsqMVNiRQDklY4Vlgap/Qpoe8EDERdBI/QtaluzGeMkXZFf
	d8hKZM46QZCTX7eQmu9ho56TvWc3ZlFQsGVpgBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/2yLtb0lmHljW4hWUpUt6pzuYG/NjVKkup+ztfiLlII=:JwSsDL9+hpoBnefcwHqgokHOrrIkqH+gAAjxEIACT0g=;
X-ME-Sender: <xms:5MXravOdBY4STcaIdyv908OnLMk7LG1vRiCbr1uWEWEcYJLkxUrGyw>
    <xme:5MXrakwkiammKf5WxrdqopDOVdf-nlgAcke3pqWQSriFaF4h-gA0Ewrz1MWLIVIUg
    mpYIvrxxxJaFAn26qEDfKXTtsrk7EhNYvmQDw7q64gqsJdq-hQW>
X-ME-Received: <xmr:5MXrasiIOJa_eZEc_hzzjuBmYUIPH4ZPoRRo1oDnqVEJ3U7_BgIrBAg1oTCw9A>
X-ME-Proxy-Cause: dmFkZTG4FYuvZQ8OKmh8SxPpSxFmNX1nEZQbXphDSfzzHzAlc2MER1INxCOQ8ioQDOLSqj
    I1J5zCHbWI6FBxNlzNQLTNQSnlCUlwwphJo/pu8XArSbdA4Ni0obfntvgtOtkOVBNwetlV
    bMJgK9onu3dmOMmfOPZ4+y0a5pkqOK0b4gbgM3rL0NUyZ3bUwFePMC7fr20AQZulFyoaxC
    8n2SIP8sHCkz9WtgPer+7UYjbsFsL8a2bS/6zWjf8AyXuy8yXVn3TL3Nz9OaD4UIyDwBDB
    SY1wk2MHyzJunerzJ8Z+CamAY0fsFExRiKHjQNG41SIr6RTph7A2ETmq/kOvDwQe29bHhL
    n5ocRvmGPyFRljf3Qo62VxDoSLiGsBnOovUztkkBp50TtARwghYPJgDAfzSfCjMXn/FlYH
    kFIrhNHcp8cEPcC00vuEAWeAPFMyggNnERoRxujS8IIq3qOdQ44t6J+VNx9UAmvv3BkLtI
    ZX33pFJ71IfXai9X4V2/mF8pgXeBqY960hA5/Rfh8Yk9T+tvNyjaMaQXjtzk/uzwTrVOpi
    SNMhKiBfqNZNpWaN2k1HzBHUwnrF+/wGpeljfS8EhvC7QAz/3ecx5m+5/jHMtwvTRcvl3B
    iy6VAazlxu2j909ugxbrpkUry00PTO6/RmB4jTGTh3lx1zMLhldtwDMyfa5A
X-ME-Proxy: <xmx:5MXrajSlPVPBJVlHc6p7x4fWti4uEH6aQIHR-v9AouqkOzcnmcaYRA>
    <xmx:5MXrahOQKxvpqdCbMH27I3dVQ8y4IRkY7D_FYkWEqw17SEKikA0o1A>
    <xmx:5MXragG1Xwt4n8WJBRhYtFI2ikTPJUqomOndok5F91CbEWChwMgcww>
    <xmx:5MXrapgToEx5AYtHv4dBBDwdiWaJYCm10Y7l1tRCpnv8j2en28XL7w>
    <xmx:5MXrajccpjpBoglgV8fA73y2VYoxNJv4GexxBh-JIQ7oN_uyJXh9bz58>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:55:13 -0500 (EST)
Date: Wed, 4 Nov 2026 16:53:23 -0700
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v6 05/31] PCI: Refuse bus and slot reset below a CXL
 port with SBR masked
Message-ID: <20261104165323.78b45467@shazbot.org>
In-Reply-To: <20261016161839.2765592-6-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-6-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:12 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL port ignores the Secondary Bus Reset bit in Bridge Control unless
> Unmask SBR is set in its CXL Port DVSEC (CXL r4.0 sec 8.1.5.2).
> pci_reset_bus_function() already returns -ENOTTY in that case.
> pci_reset_bus(), pci_probe_reset_bus() and the slot variants do not, so
> they report success for a reset that reached no device below the port.
> 
> vfio-pci uses these for VFIO_DEVICE_GET_PCI_HOT_RESET_INFO and
> VFIO_DEVICE_PCI_HOT_RESET. A user is then told a hot reset happened while
> a CXL device below a masked port kept its state.
> 
> Return -ENOTTY from pci_probe_reset_slot() and pci_probe_reset_bus()
> when the bridge above the bus is a CXL port with SBR masked.
> pci_reset_bus() and pci_try_reset_bridge() probe before they reset, so
> they refuse too.
> 
> Users see this in three places:
> - the vfio hot reset ioctls fail (vfio reports -ENODEV when neither probe
>   succeeds),
> - the reset_subordinate sysfs attribute returns -ENOTTY,
> - vfio-pci groups a device in a hotplug slot below such a port by bus
>   instead of by slot.
> 
> Every other pci_reset_bus() caller, including the vfio bus reset at
> close, is refused the same way. With one device per CXL port both
> groupings have the same members.
> 
> Leave pci_bus_error_reset() as it is. AER and host bridge error recovery
> call it without saving or restoring state and only map its result to
> recovered or disconnect. Failing it below a masked port would turn
> recovery of every CXL device there, memory expanders included, into a
> disconnect; that is a CXL error handling decision, not part of this fix.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/pci/pci.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cecf8e681e69..87fe9de81acf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4984,6 +4984,20 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	return true;
>  }
>  
> +/*
> + * A secondary bus reset below a CXL port with SBR masked does not reach the
> + * devices on the bus, so a bus or slot reset there would report success for
> + * a reset that did not happen. The probes and the save/restore resets that
> + * pci_reset_bus() and reset_subordinate use refuse it; error recovery
> + * (pci_bus_error_reset()) keeps its existing behavior.
> + */

Reads like AI over-explaining a fairly obvious concept.

> +static bool pci_bus_cxl_sbr_masked(struct pci_bus *bus)
> +{
> +	struct pci_dev *bridge = bus->self;
> +
> +	return bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge);
> +}
> +
>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *bridge = pci_upstream_bridge(dev);
> @@ -5615,6 +5629,9 @@ static int pci_slot_reset(struct pci_slot *slot, bool probe)
>   */
>  int pci_probe_reset_slot(struct pci_slot *slot)
>  {
> +	if (slot && pci_bus_cxl_sbr_masked(slot->bus))
> +		return -ENOTTY;

Why would this be open coded here instead of pci_slot_resettable()?

> +
>  	return pci_slot_reset(slot, PCI_RESET_PROBE);
>  }
>  EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
> @@ -5638,7 +5655,7 @@ static int pci_try_reset_slot(struct pci_slot *slot)
>  {
>  	int rc;
>  
> -	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
> +	rc = pci_probe_reset_slot(slot);

Also suggests it's tested in the wrong place.

>  	if (rc)
>  		return rc;
>  
> @@ -5685,7 +5702,7 @@ static int pci_try_reset_bus(struct pci_bus *bus)
>  {
>  	int rc;
>  
> -	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
> +	rc = pci_probe_reset_bus(bus);

And again.

>  	if (rc)
>  		return rc;
>  
> @@ -5726,8 +5743,13 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
>  	if (list_empty(&bus->slots))
>  		goto bus_reset;
>  
> +	/*
> +	 * Probe without the CXL SBR mask check: error recovery keeps its
> +	 * reset path below a masked CXL port, and pci_try_reset_slot() and
> +	 * pci_try_reset_bus() refuse the restore path there.
> +	 */

More AI?  This function is not designated as exclusive to error
recovery.  If sbr is masked, slot reset doesn't generate an error and
doesn't effect a reset, regardless of who called it.  If we're including
a new condition for a bus/slot reset to be effective, it needs to be
applied universally.

>  	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_probe_reset_slot(slot))
> +		if (pci_slot_reset(slot, PCI_RESET_PROBE))
>  			goto bus_reset;
>  
>  	list_for_each_entry(slot, &bus->slots, list) {
> @@ -5773,6 +5795,9 @@ int pci_try_reset_bridge(struct pci_dev *bridge)
>   */
>  int pci_probe_reset_bus(struct pci_bus *bus)
>  {
> +	if (pci_bus_cxl_sbr_masked(bus))
> +		return -ENOTTY;
> +
>  	return pci_bus_reset(bus, PCI_RESET_PROBE);
>  }
>  EXPORT_SYMBOL_GPL(pci_probe_reset_bus);

Redux, pci_bus_resettable().  Thanks,

Alex
