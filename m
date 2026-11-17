Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883946;
	b=UoCdnRiWMz56349fwdZxjAO+YmwLBpG2+zdpvG9g6ctcvBuOzsT+VMtQV2Qpdo75ue5A
	 JmTuMQL0YflA/9qO9PUzudfLnahW2yVrTFrOfU9t3pLSBwaS8hulPs3iMJcaDb+03h2jI
	 KVQjWqdPVii++QWrmzTxlgeErHc+HFs/6+wmC9DpxagYwVZsf5DDfe8VMzktN84QmBLVi
	 Cr23ec8YViGmBziNtefK9TLd2CNYXUxQsalAk7QZKq0624P2rCwkVU1fQao81LYThaHzi
	 gUGVBX7H+mMN936Vg8fxgMemUrpj+BQFKPUs3a8nuk9LPW1pclr4qi8KGvXOhlStSjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883946;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JgfoU/2rttrrhzPFJX09pmaRfF5u+hpZcsvo5/+6at8=;
	b=UsOiZ406x2S6VFl3xiRurvOzJxwykxBnntjVGt/+Ovb3YNB2KwgcEDYdgWamcwDZP0Zz
	 kiK1IkP3tXgj/ibK+EOAOw9KGz/3s3rVWLbMlWpSfRFBrLPauHI9zqGT7TEmtEnYNkotu
	 q5yK4XaOHRMYRjoVsGrBACcbf3AZT0a/iTl8VL8lCTpU4K/ij7c3hS8BwMfY4ByoMSg7U
	 x5o+rH6Pj3mBQInRKWawr2/28Ys4proDNXmr0U6M7rZT90DBS7rhf62V9kMtZMSwZC7Su
	 9KvPBkut41xuS/nwve2s2b7F8i0qb4hD+U2W8gFNM48NlMbTE5rachg6P8S9MENGyRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XgThOSB3;
	arc=none smtp.remote-ip=95.215.58.213
Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB04606A31C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 02:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XgThOSB3
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=etM72AxM7HyhOHVdSZdb44ly+cIJWbzbD2izMnrOzLc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794883944; v=1; x=1795488744;
 b=XgThOSB3IFcpCbXcSK2JzyUMhn6hYAZzB8PHyLC1CdGkM6QTv1kHwJ9mj3SIXzHSWYO3v4v9
 UODoPTQ1O+RuNYGUpqmVDLqnH6lCEcbXXA3x5uRPVGHf1ZztMx8CZAsSsi0A7wUQnK5FwCTQDeQ
 xvMnrxH6ywtkX5rOnRXFTAsw=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad60b2bf9274a504;
	Tue, 17 Nov 2026 02:52:23 +0000
X-Mizu-Trace-ID: ad60b2bf9274a504
X-Migadu-Flow: FLOW_OUT
Message-ID: <b4eee4bd-0356-4b6a-89f7-db6eaaa29949@linux.dev>
Date: Tue, 17 Nov 2026 03:52:23 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] platform/x86: eeepc-laptop: Convert to
 pci_assign_unassigned_bus_resources()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-9-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261116152403.2672-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/16/26 16:23, Ilpo Järvinen wrote:
> The eeepc-laptop driver scans single device and then attempts to assign
> its resource using pci_bus_assign_resources(). That function makes
> bridge window sizing disjoint from the assignment phase and is going to
> be removed.
>
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely no-op in this case
> as it looks like bridges are not involved here.

Hi Ilpo,

I don't know exactly why, but this smells like what I had to do in
asus-armoury: scan the pci bus for new devices.

It has been on my TODO list for a while (and I think it will need to
stay there some more) to try to understand why these are even needed.

Dissecting the ROG ally xg mobile ACPI I found the signal that is supposed
to tell the kernel about the hotplug, but it's either not reaching the correct
part of the system or the triggered rescan is not on the whole pci root port
and the linux kernel is searching for changes where those changes aren't
possible.

I have some more notes:

In https://uefi.org/specs/ACPI/6.4_A/05_ACPI_Software_Programming_Model.html#device-object-notifications
I quote: "If the device is a bridge, OSPM may re-enumerate the bridge and the child bus"... The kernel has handling for this already with ACPI_NOTIFY_DEVICE_CHECK but it looks like
what needs to happen isn't happening (probably is re-enumerating only the child).

I will need to debug this eventually, unless someone more skilled then me in
ACPI and pci takes a look at that and solve the issue properly without
triggering a rescan, since the ACPI notification is surely there (at least for ally),
not this exact case.

Best regards,
Denis

Reviewed-by: Denis Benato <denis.benato@linux.dev>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/platform/x86/eeepc-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 8a640c25830a..7394221cbad1 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -609,7 +609,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>  		}
>  		dev = pci_scan_single_device(bus, 0);
>  		if (dev) {
> -			pci_bus_assign_resources(bus);
> +			pci_assign_unassigned_bus_resources(bus);
>  			pci_bus_add_device(dev);
>  		}
>  	} else {
