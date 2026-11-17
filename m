Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950658;
	b=bFrraoyat7gB8RmdXmGsaTvoX4o24SR0xwtXMn2fWJBHcjkIjry/kcOgPIoRfz7tkvaN
	 OMyuLfKHn82Fu/MN4g5ONNkxcbHusx8Ju1nnjmsM72NCA1M8WE0EDJ2ZQOjBreDz5Ra+Q
	 oCNmhF7sWj5dMOlKMsJiD1nM9+pJp17ND6Aw5jjCGWn1RO76OqkV0NQioCXw7+/1gYjyP
	 8uG9HfDSe2atxEMAqg4MnWZw7MZG8LBDwRgBtJN6q/JsRtlp2I8h5PHT7TxV3XfgvAGkB
	 o4gDiY82YZSeuBeAAo6S8elt0H2nSwIh24a4+V3EFGgumAGpnnAPdYg/mShS4cRDxKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=J/fjCpBeMUF8gNXxUY7RYX8CVW+S81rP+s0YQaibwOw=;
	b=bLy6oBJwQ6ECd9IxFUDsp8iQaIh6wujcw63DAqU9MY6mMsZUMgGAzRtEfOOi5Aq7xQFC
	 jWXjays4uoF2FktRgOR0uxD3Lge1vJFzxoYUNK4xm/OHbge2+8UfGN4hwjjul3y40RVtF
	 R8NeT4CG5q3CBdDuoyNDiUnW7D3eMHGrKPNqOOA37b2nfPsEak2ASuAvHjQUKdn/4NFQ9
	 NzH0lebTiwQugTr6SmYF+iFiVXU9TYh5O3ynHw9s4HS9/mKjGS4bmwx5WQiMVrko00GS+
	 1VekJ0gjz0kwWUWifKdBPJoy+PGw9BEqFq0Zypwmzl/KsLnqFwRMSMPx+3Fgo4kP/9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nxr9m7DQ;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7037606A32C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 21:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7037606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nxr9m7DQ
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed2bfe3252so1115345ad.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950657; x=1795555457; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J/fjCpBeMUF8gNXxUY7RYX8CVW+S81rP+s0YQaibwOw=;
        b=nxr9m7DQhADZJ0A11Vgtv9+ajmQSQVyjgxlF4UwAbRrS0p+4aLCL0I3w9+n8hCnAcE
         kjwiv5TjLKTSGMaG913wevcCAjy+0kZFu0WQDUaACQ06JCCjpAQEgkqWNeh/KD1jGktI
         ynt3rXfYw0l0vQ/YqcKzSN7xwFu7Rbe0jP1QxDANz1zURk/krMd5ubwFuWiIxzpXqBbg
         jFXwEKz0rfsOmVSIhERyJ6WHu+KZ0H9I3EM7G+f7OB/0bYQ6xsUORuwZ6r70SEvLo2rH
         hLxNxv6VSg1nz8Gf8vmXTRaGufNR8it5NUuNFRh0JEBJCW5TkDavFdqZAK5rDa0c60Rn
         Ui3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950657; x=1795555457;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/fjCpBeMUF8gNXxUY7RYX8CVW+S81rP+s0YQaibwOw=;
        b=sAYLXPsxmTqCpRJd4Sj3pkC0iwC2lzynhV8PryBOpEHGVCY9paHDvWL4Qp+v+M7shH
         MifRx+FvTx7lVh98wUJiMbKjQlRPaDQSObmnWDg2p+kfdhqX8HM3wh+MOkM/HifwF7Bz
         paIV8lSGHqUpAkrKJBDBR4TTE7RqfGpAcLDizBF0zq1tKE+z+gshDpDHj+okwMJLmeeX
         vmjvR0B0KueUbSYehucsWBzWVcEwOc2syIccZOUofUFsjl5Q9vIX5vMNwZet4hWwJYsD
         HV9etuOHsTQkhs2nz0SaHyOzeGUa1ehuntxqJLON53uX5ut31ARgYzKTvOPGQ8n5MgaJ
         +9Kg==
X-Forwarded-Encrypted: i=1; AL+hErFOm3rrkwED3m5P4gSg/A+vNoMFvZgeMUwJjfvXnBcgnqv3rjnTy6sK66rHh7nmMXPgeUAqucYFftY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ak7TpFeJaKoE0ju836fGjZbMtnp+ZMM4ItsnDTwLcXmEs3/A8
	t/XmTWOhkDFojQoF6PTn8bx1FeaSMjSY+54CAAKp2elsfg0qZr+YTZA2cdurmB/UuA==
X-Gm-Gg: AZFdTZcBliV0k2K/LJZsKSiMxbva1seJwuspe8yZRY2I+8ZniYpqbYeYkwQIGCOqR2D
	Sg1+8zyoDRuHd3lBDG/hQK3Sq8bLntoTAErhzzJQFYlx4fRpj6rwMLYQg9P794BjOTT2Ya5xncQ
	T5niPPYhevyLPIUZcFdpGdkcY0NxxpkrQqV1etZ9QLF7kOK70XiGVoZOYDQ17DpiOGqTH8sh8AA
	zuTFNF73GMd5UmXu3zMUyHEIUdncToou3gR3US7dQQJuUf9j+kSIjOprJkhLeALp7DmaQUWLbJb
	nSbyOUnRejPGcMxQzRX5oLXIrbsilD8pEaRQ3mha7cuCzqavDC8bH9IQn/kEjlqsW9xhzrPKrYJ
	EphlFPnRgOWpqdWYh+7Ix/SVEZFKla5QicVyTrs24As4wwlONPrvrY+1cFbHYbT+ELygBIykomX
	FpJaBn3KhTVrWcPCgrWqvQWdE+BdZAO0sGHfxBLxmPa7ehiZhBVbxLnWn6175ZyYfuYG9VVc4/+
	NW9dYDfDjE/1Hdh7gzIwUUN2CDj1xmzJuo7gglVWuDRqBkq6oJbqJDQhdFtURY0A05ma6DRldEQ
	mCQbleaI8d+3/M2w62JBhl+MJAWxjXYoPv/3c1NF6tGAQnXTkPw8SGppb3V/E3+q
X-Received: by 2002:a17:902:d583:b0:2ef:ee74:78e with SMTP id d9443c01a7336-2eff72ea998mr4954175ad.13.1794950656357;
        Tue, 17 Nov 2026 13:24:16 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff617eb61sm2650725ad.28.2026.11.17.13.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:24:15 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:24:15 -0800
Message-Id: <DMXSWJDPGJLE.30NVP7WQSZIZ7@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 08/13] PCI: Save and restore the ACS Control
 register and Egress Control Vector
From: "David Matlack" <dmatlack@google.com>
To: "Alex Williamson" <alex.williamson@nvidia.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-9-dmatlack@google.com>
 <20261116171017.2342bd11@nvidia.com>
In-Reply-To: <20261116171017.2342bd11@nvidia.com>

On Mon Nov 16, 2026 at 5:10 PM PST, Alex Williamson wrote:
> On Tue, 13 Oct 2026 16:25:24 +0000
> David Matlack <dmatlack@google.com> wrote:
>> +static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
>> +{
>> +	size_t size;
>> +	int pos;
>> +
>
> Nit, moving the device specific enable test here:
>
> 	if (pci_need_dev_specific_enable_acs(dev))
> 		return;
>
> Would avoid:
>
>  - Allocating a buffer that will never be restored
>  - Saving ACS state to a buffer that will never be restored
>  - Testing for the device specific enable at restore
>
> Otherwise,
>
> Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>

Thanks for the review.

I'll make this change as you described. Preserved devices will still
need the buffer even if they match a device-specific quirk (see my reply
on 09), so 09 will also allocate it for devices that were preserved by
the previous kernel. Since restore then just checks whether the buffer
exists, that is all it takes for preserved devices to keep their adopted
controls across a reset.
