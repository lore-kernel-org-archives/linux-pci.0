Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119207;
	b=kgPpks6sQ5HUhI3qASiQXaahNtO4BKTS8uuUz4fgjHTfqeEHqqIe1kQU44TlDAfG4atS
	 cJFAhDrsLeUIfl84dYIU37prDssmB++vsHkHteL2fHqJHjA9Y0tnOJJrzipxb9kXk1PAE
	 cndxf3XIB/O1o2Xcmp71DZ/eYTEAjhdcL/XuRx6BxvVFfU9IR0NfEAy3esvLMpszuOKNg
	 eq7Vs11XUJXCqlWaxznD7dYOrOrUdYlORl88Z/UGzGnh8c4PTQKd6ADb06Y94Pj0xC79q
	 pKcHIiKH8IMJmDr1RtUqh7M7q5MOnC7rhb44SHVtnHowrJLNZxC/6n7wktZztVHv9bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gbXuStreYRF1M4k9Su5zd2++RJBOLVmoBCN1Uwl3TZ0=;
	b=n7ttW5InI0fGjHl7uMBsch0zYr1IiHlfrBnpZQnt8mzJ0sfxuJfSjkY10XX2EypBe1vv
	 D03MUHNzYJ2m98QPLyI6pJ7lGYolTcLDCZyhdM0roBhjXvWjwtkINOevl2KuBHCCMA/KW
	 B+LD7qbQuSczgQUwKc3/mKMtz/KBzlYRt6q5+u/xL6tS0trWbbKsrIBuw9j8ShfO/b1Um
	 H6tfu3o94Wju+fSn4Pi7r9f06RFIDC6njRLxrQmM5wbhYellY+qEM0IOpBGoLmsbV+P+l
	 aAMHoABgx7ZxizPK4ZQ5jdY1XO6CD8h8LHfYL+n6zmYHzg/Gol8O4PCWQKCz1AJK2Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Zr7ScxU7;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F4606A31F
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 323F4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Zr7ScxU7
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso55733241.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793119206; x=1793724006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gbXuStreYRF1M4k9Su5zd2++RJBOLVmoBCN1Uwl3TZ0=;
        b=Zr7ScxU7LPpcpVmwcDfMzimPKelujj7KZMOtx1IyuU/S4C/UO70x0+DX+9QyLeh4a9
         PmnVMdTOIGZWjWfC32qpJTjsEOC22/b+oVbdoj4aCBNhoaKTVm1iXV86p4vUFu1DVnFw
         dI3uLv4u8RrIQ01IQQfwBwKfBFnN2w4rEe4Crl4lu8CTZuhY3dzGQPAeBoRy0oN74oAs
         HLZUUQkXC2wsvk+R7B8NW2djal7BYB5QrNomAMvVxcHd/eztF+MMYs5OANCNnv+Bhofs
         R3maM6BL/pFwDUgY2Yc4GszR7T33hmDEDaQG4LcAerPIgwmq7BHN1OF57ygqfvNBL0ZG
         sYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119206; x=1793724006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbXuStreYRF1M4k9Su5zd2++RJBOLVmoBCN1Uwl3TZ0=;
        b=dtBQ0TqZUfTH66FMYf4aNq6tedFRcYdc6vR3e/7D6siI3Hte7gFpTKVZD/InzK0U+p
         WHpwIBs/yZk3xDUwVJqqXzY3QyHcfdSWfERyR5vQ82VEp3bRX2T53hx9nFkA61zZacXZ
         ZIdxNwMschM02ut/libvW5bER+vh1PaavTgoFIiBL+m6udLR/CK1j4jDgn7073AfcmtL
         NDbGXKcEizVwd1Q7VpAv7uuvCuJzKiswRxIsLTbkJuNIQCBEodWrl3vcI61BS5IG+sg+
         YnKMdwOU85PZa1d1CG/BIqNM/ZCN/s4+Xd6NmX/pOiILiR+lGdZyDm3f/bsypguASnow
         LDUA==
X-Forwarded-Encrypted: i=1; AKwUvByNBGutvLN0rDG7JzRRyyIEJvPB5Lu8yHI7+Bl/iI0MqAkU3ALBGKT+wQuy5TOasDREr3yEyOwyibA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+WHGnDkP9u+JO2BBigAfsBJENEl8j57QnDdl5SaBaLelbk3PZ
	+YPD8jvzSnyQkFSflXYq/z1hq3zxjMYdwwYDdz0O7RslieJ4PVNrbWrrn84dWZGSu9Q=
X-Gm-Gg: AYBFou3t6apCq0gpTKXwWb7hoAjuVU3Sqk3MGoCdZMdJLjmWHvINX9yAOAgjVsMIkCj
	xkfvxKTEbn8HRB5QygjlMpVaqju7u+eYBi+hTRAG1dqkC25snApiG9F8dnG3NQ5DmgT6Pfy0SqO
	Lb0fKPxKp9ihWaMrqzsbDr+91sOLesILT6TNLKnU3NqHcna1joZghKp6VMawXOCfUC75mkEnS9A
	4W7DpZlFu0plxe4Hsr8zS4+nZ4LOTW5DMXVtHx1kwaSAGVoUkRZPbD3dMKYr+v7d+ug0fzvr042
	Y+wM2V6r4JfUjmn+Iq5AY04TWGaVAcfnF8QtUFcZWYRMD0hHaeonS3OaV85BXyGkVugmsdoCyTJ
	JNdPaDYwATZv0GD7134D4cWdkSfgUf14a1KSxD4uVq6M6aw5vo9IKLq5lcBP/Ocn2cbaRMSnTu4
	9Bhx7OWxeShNEK6c2XqFGTgJqABKM7F+x5v1k/VC7UdRnUWHDw/WpMU/mjz8lJTvQ27G21Tzk14
	DaGoFTKTrTXotHgszT1JqxXPKMOAj7oH2PSc7f0s/cKeQaEz/lD+rXrzsX+50Uk7yjXKh00iX3S
	3njBRIaa/bxVhS2L9Cho3lKHXjm7nD/4tXcXvhJ1AB1jXHWQOffjobiZvPC4wbfZH+8elqQYviC
	Pwp0kT0MZKqdUwpTk+zNYt58q1J/NXUnXApG3H5+TGg02D/PNAJQ=
X-Received: by 2002:a05:6102:5048:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7ce5ce4227dmr3243460137.34.1793119205875;
        Tue, 27 Oct 2026 09:40:05 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9912da2d9d1sm442866241.7.2026.10.27.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:40:05 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:40:04 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auDT5MjXYq3lcQjE@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
 <at_CncIPYCxOVkLo@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at_CncIPYCxOVkLo@google.com>

On 10-26 21:14, David Matlack wrote:
> On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> > Right, Required bit should be source kernel payload property to tell
> > target kernel that the payload must be handled to correctly deserialize
> > the data. It should be source kernel (userspace) responsiblity to make
> > sure it understand the target kernel before doing liveupdate.
> > 
> > Saying this, During deserialization, target kernel's required bit is not
> > necessary. So I propose the following truth table.
> > 
> > Source hdr  Target supported[i]  Action
> > ----------  -------------------  ----------------------------------
> > 00          0 or 1               Accept: feature absent in payload
> > 01          0                    Accept: ignore the feature data
> > 01          1                    Accept: use the feature data
> > 11          0                    Reject: -EOPNOTSUPP
> > 11          1                    Accept: use the feature data
> > 10          0 or 1               Reject: -EINVAL (invalid encoding)
> 
> Yes, this matches what I had in mind for the semantics.
> 
> To be explicit: the source kernel should set the bits for each Live
> Update based on what is actually preserved, rather than generating the
> header from a static per-kernel array. E.g. memfd would only mark a
> feature present for memfds that actually use it. That's what allows
> rollback to an older kernel as long as nothing being preserved depends
> on the new feature.
> 
> But looking at this again, I think the required bit is redundant. Whether
> a feature can be safely ignored is a property of the feature itself, not
> of any particular file. Every file that has a feature present will have
> the same required bit for it. The only thing that actually varies per
> file is whether the feature is present.
> 
> The required bit still has to be conveyed to the target somehow, since
> the kernel that needs it is the one that doesn't know about the feature.
> But it can be conveyed by the feature's number rather than an extra bit:
> split the flag space into required features and optional features, and
> assign each feature to one of them when it is defined. This is similar
> to the required_flags and optional_flags approach in struct pci_ser [1].
> 
> Keeping the same header shape as discussed with Pasha:
> 
> struct kho_ser_hdr {
>     __u32 size;           /* Size of header + payload in bytes */
>     __u16 nr_required;    /* Number of required feature bits */
>     __u16 nr_optional;    /* Number of optional feature bits */
>     __u64 flags[];        /* Required bits, followed by optional bits */
> };
> 
> Required feature N is bit N of flags[], and optional feature N is bit
> nr_required + N (using nr_required from the incoming header). The length
> of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> are numbered contiguously, so there are no gaps, and up to 64 features
> still fit in a 16-byte header.
> 
> Each bit just means the feature is present, so the truth table becomes:
> 
> Source bit       Target supports  Action
> ---------------  ---------------  ------------------------------
> Not set          -                Accept: feature absent
> Optional set     No               Accept: ignore the feature data
> Optional set     Yes              Accept: use the feature data
> Required set     No               Reject: -EOPNOTSUPP
> Required set     Yes              Accept: use the feature data
> 

I like this proposal. I bet most features are going to be either 
optional or required, and even if we ever have a magical 
sometimes-optional feature, it can have its own required flag. So, no 
need to pay double the cost on every flag.

Just need to make sure that optional features always start from 0, in 
their own enum, so the offset can be computed correctly in the incoming 
kernel.

Pasha
