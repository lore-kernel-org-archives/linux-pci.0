Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B23C98B5
	for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2026 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639891; cv=none; b=ftAY1C9AqkhBCn3K2hU6n2Nwe215cgs3eNW3utXAaRVDopn1I4478XYn6c9YuWs8Fw3NqbEVbN56zlZr9efogf18PECAfqNOx3MLFkTqTNBddOfo/kp027LnOu0r1IJ8dLrDuWcxcFF+Wue/bTg2iPJ00eV5vUxC2xs57aLeX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639891; c=relaxed/simple;
	bh=bDPSYW4sbBXupjVGuQ9fNmCdsAtmh74koaGYMZY927s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHoBPyRbcPJPoz1EJ5O/l6Uga+BwX41z5k6Rbd4Wz4G+Scbni8+kMf7nxu+O8RI+1l+CrTF8QpLi0u5xz3D29u10szJ2N1VTcXbSyDPE9C2/21KBZuetc/MTdgTbX0ktE/svL2BFdJe/cJhcX0+AsZK2QmCi1Bl7KhK+IGXl31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ac8UwFJC; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ac8UwFJC"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-133362c30cfso9157c88.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780639890; x=1781244690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+JACYJJsZuvAWWpivo6XAMCeidn10mj5aCjcUHoRua0=;
        b=ac8UwFJCMdi8cGmFT7lTPe2kToZwck/hosTgZ+nKsa2tc3jel7u2SOWhFUd13Vu1Gz
         1Wx5PK7EpnoGe0kgKQjmZx+yX9Z+MEHvvZqIAboO4H7HnLpSqgRM8QHIt9BoFK4apFck
         /QvePhnw8yE2v01+0MWo56rAT57153ut56VKfl61YS9fIJoS56EY4BQeRIYxaZr/mZN1
         SqzbaWHnME3f0V8LtomNdkd4EsflEW0F28b7ZFsn/uH8IVXXDPM+o8qdcXQ5GM/jAIDV
         aCcdMAJ/IoiB8vRivJ71j1+QlZQPCyC/0u92BfVhNKefBYk6+CgwIR5wabnWBalm6D22
         jsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780639890; x=1781244690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JACYJJsZuvAWWpivo6XAMCeidn10mj5aCjcUHoRua0=;
        b=DXNPbzd/jCUreSUW0efcqlK01GvApgDk+tFTM2rz2cnPrkIgD7XdeLq+EYtXSPpluI
         aCoDfBsmIf8gSmuRtOo/HAivmveaiG3Euy5DayW7eEEu3H7hUsY0tQBEZtonD6YrLm/J
         lJ1V6bKyt3CrkXyUvOzqY4ST/FjSY6FxN6eKn0v1EQKdbFApKObT3lQ3ZglJerZ2yK9F
         Qa8ta6+4cmP32IbHkpPvJ92X9Ea6cVERX1JhwX+D8YcnlJV0xGNYpaAPJBppPxtiKXDN
         UAlgkqTSB0gYZv4DNpoSAfA8DwucLCoN3Q8KNoLoiP+c4VhKeWfidddqXezgs6HNJAbe
         Pl+w==
X-Forwarded-Encrypted: i=1; AFNElJ/1Wm1A+QkVHouPTaS+xWEAKDGTKuHGpCTlEVldsPG2WKUOIXD7f2/ahhYGe2m45zDHQ29M+sNu67A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIx1hQL8wLnurPJ2n8SwPTivgdCpWGYDjYaQY7FHABOmUkUHc
	Zvt62Aw8K2Lsv4hkklCxQWklmJBMyhSTAwGWrZOEOdbMn0D6zbbtDORRx4DQrwNWVA==
X-Gm-Gg: Acq92OGHVBuDKopYU1fXQ55di/4itz/3cDnlyIi6E0YzrOhEhxkXDc9wlt+zD8AF2rh
	Thmb28PQTdt8Be78Yw2TRJxng4A9YOpvwZwQHE76flKiKI2yAgdfjuGfkbeasFXhrmru4k6IeW1
	tYQzFmxRrHhvW4pJ2dtpVwmUzC6TzP6C01LbPkK+6w9zUJrBVnFuLZ2lDN1Lbz8H9QMqlQmN7ka
	gYmh6NAc8uueQ/H3L9LUfUoCRjVRcpnPKrR/mIMSnPqy7PjfdcDc/eTGKOmTpaXHnMej7RBr+wa
	HFSq7Gj0d6ZjiZBm4ENSHw/9f5OHhk8AMyeQxtZfR8SmAEbOBIHFRYib6+UkbkEyGujmWBieABG
	N19gpx9pSC3gCnjLqzuTq/Fbsx8VW12VgQKgWwGX+6oWMxn516ohcYU2zw3RwWampcJQS4wi0PO
	rxPF/Ftqmk0XhdZI4vORsQbtJY+u74Qoh0fi3A2zSk8r75Q5UX+ewGglBpoaRs3RKY6Hj5RE8=
X-Received: by 2002:a05:7022:6289:b0:134:a710:ca44 with SMTP id a92af1059eb24-13807ccb5f0mr74668c88.18.1780639888034;
        Thu, 04 Jun 2026 23:11:28 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074d9fde90sm10632107eec.0.2026.06.04.23.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:11:27 -0700 (PDT)
Date: Fri, 5 Jun 2026 06:11:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <aiJohr2dD6Jf8m3r@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-3-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:00PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> 
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
> 
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so that it can be
> handed off to the next kernel.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

[...]

>  
>  /**
>   * struct pci_dev_ser - Serialized state about a single PCI device.
>   *
>   * @domain: The device's PCI domain number (segment).
>   * @bdf: The device's PCI bus, device, and function number.
> - * @padding: Padding to naturally align struct pci_dev_ser.
> + * @refcount: Reference count used by the PCI core to keep track of whether it
> + *            is done using a device's struct pci_dev_ser. The value of the
> + *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
> + *            0 otherwise.

Note to fellow reviewers: This may seem like a bool instead of refcount,
but this is changed in Patch 6. 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
