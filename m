Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B943355F5C;
	Tue,  4 Aug 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843549; cv=none; b=rMRbdXRNtSPzA/Z7U0R0LwJPz6VQ91/yvUaI+LxeU7+XycMCYmRP38MYzIrfY3qKdJ2zISLo+5fEqZxfWOZWdGKp3J1fXkDTvlKH7T3rtbfBryzHZV1JGzD01Q7uixYX9UiIA60IgplHyuQmiHmib/Mjn7e5JGeOk+A0Ik8ZMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843549; c=relaxed/simple;
	bh=p+DJFh7RLq7GaqRkqbH6BV95W4PmMYR+V5BcC9qDWCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XunDAVG1HEVFIR6E5hRvXJvEaO0lNT3Iu+QaRLBz1No4q5tCpgqwDmWHChhxeVITEHKOx2xv7w/0Z0qhGjt1av2g/YLTNegGlIDVuS3Ii1FQrYzzM529E8vG78CsGkbfiq2lRqVzaVreP/HlyCktmPbIMc63IZEvXOTxCQxp3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2ixbB06; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2ixbB06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843547; x=1817379547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p+DJFh7RLq7GaqRkqbH6BV95W4PmMYR+V5BcC9qDWCE=;
  b=G2ixbB063h8mh/A3Ta1vi+NiOOXuZPdI2ZkzeGVAyLm05rkESxinkj5s
   AOAOvhNtV5KLQFnopp63XOr8yUOtrr1fhof/4yPlH7+9ou7Oa4694amSV
   szJorLdYoDEv+IQ2soOJ6YKHoeSPAw8HeQ/kfNJZ8pbTF3usBo0bOyzFd
   R/wDgel7Tq3g3VVL8B1UW6BjeqWdDkRcvRROwhYed7TDTT/C9cdac5Wku
   A2ZVzVTQoADnJKYDZX5Rvmlk2UJbGy/ptoIwmV35759TwV/tbk1HsYcuX
   MsOKxvYlnbuAz/JM5LrqowQIM3tKfhH5bMuAoIwDMc99AeSiYIgZ8NLeY
   A==;
X-CSE-ConnectionGUID: 13StSBLdQYGH1kM5+klgZg==
X-CSE-MsgGUID: j9OTHTdmS62GWrDHzhOgdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86424808"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86424808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:39:05 -0700
X-CSE-ConnectionGUID: SRO4CRgeTq6Mf9pVouNmpg==
X-CSE-MsgGUID: UqvoBGmARlyz3EuREoIUng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="260239707"
Received: from soc-5cg43972f8.clients.intel.com (HELO [172.28.182.68]) ([172.28.182.68])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:39:03 -0700
Message-ID: <3d43f08a-cbc2-4491-b563-244d321242e2@linux.intel.com>
Date: Tue, 4 Aug 2026 13:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI/IOV: Restore initial VF BAR sizing after VF
 ReBAR
To: Simon Richter <Simon.Richter@hogyros.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
 <be4bffdc-7e41-4fa9-a8df-c41dc6357225@hogyros.de>
Content-Language: en-US
From: "Bernatowicz, Marcin" <marcin.bernatowicz@linux.intel.com>
In-Reply-To: <be4bffdc-7e41-4fa9-a8df-c41dc6357225@hogyros.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/3/2026 1:17 PM, Simon Richter wrote:
> Hi,
>
> On 8/3/26 7:30 PM, Marcin Bernatowicz wrote:
>> PF drivers can resize a VF BAR using VF Resizable BAR (ReBAR) support 
>> via
>> pci_iov_vf_bar_set_size(). The new size persists in the SR-IOV 
>> capability
>> config space. A later reprobe / unplug-rescan / next pci_enable_sriov()
>> then sees the inflated VF BAR registers, and the PCI core reserves MMIO
>> based on that size multiplied by TotalVFs.
>
> Would it make sense for pci_enable_sriov() to check for a ReBAR 
> capability in the VF and set it to the smallest possible setting, so 
> we get the same behaviour regardless of whether this was cleaned up 
> correctly?
>
> Also, should it be "previous" or "smallest" size (in order to not make 
> a missed cleanup permanent)?
>
> I'm a bit worried about POWER, while we do have lots of MMIO space, we 
> also use kexec() quite a lot because on several machines, the 
> bootloader is some ancient minimal Linux system.
>
>    Simon

Hi Simon,

Thanks for the point.

I think an unconditional reset in pci_enable_sriov() would conflict with 
PF drivers
that intentionally set VF ReBAR before enable (Xe does this in its 
sriov_configure flow).
A core reset-to-smallest would override that policy.

For this reason, this series restores the initial-at-probe size in 
SR-IOV lifecycle cleanup paths
(disable, enable failure, PF remove), which fixes persistence from this 
kernel without forcing a global sizing policy.

You are right that kexec can inherit an already mutated value from an 
older kernel;
that limitation exists, but this series prevents further drift once 
running on a patched kernel.

Thanks,
Marcin
