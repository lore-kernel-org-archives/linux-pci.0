Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57F1F8AC5;
	Mon, 16 Mar 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681402; cv=none; b=qCxPvSv3oo81waIzeUjgHJqc4t3PevxQZARaKADpAzAXHmDQCmOXiYRMZK+l26LGMFleca7GI6ivdJfOkvRs394co5GBhXvlp1Yg472lLqCN6n0ZvMbzNHkhrV4dNCKfJoipCAuE3d2wR985BBZzeCCRN/GsxQEehNpcOQJ+ZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681402; c=relaxed/simple;
	bh=Nr1BTxQtVYheOndQtk1+z2HKNIwDmfQa+gfyHLqpPus=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNRplkS1Kqc2dw6riKPhYy2qZikRc+QU9vaH53nI2KW1fNVhqenR+hmsm/UoxYSCLS7quhnFXEpN1b8ZI83cH219Zty0eP+mp/lvX5VrCutF35ss19fivE0MpX8/sHadTSSPw/XAJiRcBkPNMvmOBCb3uLxd9GHcSU2h7B0u6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZMDb15K3zJ46BH;
	Tue, 17 Mar 2026 01:15:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id DCD8640589;
	Tue, 17 Mar 2026 01:16:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 16 Mar
 2026 17:16:36 +0000
Date: Mon, 16 Mar 2026 17:16:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
Message-ID: <20260316171635.00002bb8@huawei.com>
In-Reply-To: <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-13-alistair.francis@wdc.com>
	<20260303113642.00005774@huawei.com>
	<CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)


> 
> >  
> > > +            let addr = unaligned.wrapping_add(i as usize);
> > > +            let version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } >> 8) as u8;  
> > Given the endian conversion below, this is correct, but I think leaving it as the __le16 until
> > here is better.  We could also just pull out the correct byte and ignore the other one.  
> 
> Hmm... I'm not sure I follow.
> 
> The SPDM spec describes this as a u16, so I'm reading the entire value
> and just taking the upper bits for the Major/Minor version

Miss read by me I think... Or tied up with endian conversion I think you
say you are getting rid of below.


> 
> So I'm not sure what you think I should do differently?
> 
> > It's a spec quirk that they decided to have it defined as a __le16 rather than u8[2] as
> > the fields are confined one byte or the other.
> >
> > I wonder if we should also reject any alpha versions? I.e. check the bottom 4 bits
> > are 0.  
> 
> Hmmm... That seems a bit unnecessary. Maybe a warning though?

Warning works for me.

> 
> >  
> > > +
> > > +            if version >= self.version && version <= SPDM_MAX_VER {
> > > +                self.version = version;
> > > +                foundver = true;
> > > +            }
> > > +        }
> > > +
> > > +        if !foundver {
> > > +            pr_err!("No common supported version\n");
> > > +            to_result(-(bindings::EPROTO as i32))?;
> > > +        }
> > > +
> > > +        Ok(())
> > > +    }
> > >  }
> > > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> > > index a0a3a2f46952..f69be6aa6280 100644
> > > --- a/lib/rspdm/validator.rs
> > > +++ b/lib/rspdm/validator.rs
> > > @@ -7,6 +7,7 @@
> > >  //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
> > >  //! <https://www.dmtf.org/dsp/DSP0274>
> > >
> > > +use crate::bindings::{__IncompleteArrayField, __le16};
> > >  use crate::consts::SpdmErrorCode;
> > >  use core::mem;
> > >  use kernel::prelude::*;
> > > @@ -15,6 +16,8 @@
> > >      validate::{Unvalidated, Validate},
> > >  };
> > >
> > > +use crate::consts::SPDM_GET_VERSION;
> > > +
> > >  #[repr(C, packed)]
> > >  pub(crate) struct SpdmHeader {
> > >      pub(crate) version: u8,
> > > @@ -64,3 +67,67 @@ pub(crate) struct SpdmErrorRsp {
> > >      pub(crate) error_code: SpdmErrorCode,
> > >      pub(crate) error_data: u8,
> > >  }
> > > +
> > > +#[repr(C, packed)]  
> >
> > Why packed?  
> 
> We cast it from a struct to a slice (array), so we need it to be
> packed to avoid gaps in the slice (array)
Ah ok.  I'm learning slowly...
> 
> >  
> > > +pub(crate) struct GetVersionReq {
> > > +    pub(crate) version: u8,
> > > +    pub(crate) code: u8,
> > > +    pub(crate) param1: u8,
> > > +    pub(crate) param2: u8,
> > > +}
> > > +
> > > +        // undefined behaviour, so we operate on the raw data directly
> > > +        let unaligned = core::ptr::addr_of_mut!(rsp.version_number_entries) as *mut u16;
> > > +        for version_offset in 0..version_number_entries {
> > > +            let addr = unaligned.wrapping_add(version_offset);
> > > +            let version = unsafe { core::ptr::read_unaligned::<u16>(addr) };
> > > +            unsafe { core::ptr::write_unaligned::<u16>(addr, version.to_le()) }  
> >
> > I'd like to see a comment on why this seems to be doing an endian swap if we
> > are on big endian. Looking back at the c code, it has an endian swap but
> > only as part of the search for a version to use (finding the largest both
> > device and and kernel support).
> >
> > Maybe I'm reading it wrong but isn't this putting cpu endian data into a structure
> > element that is of type __le16?  
> 
> On second thought I don't think this is required at all. It's
> converting the LE data from the SPDM response to LE. Which is just
> unnecessary no-op (LE) or a bug (BE) depending on the CPU endianness.
I think that makes sense but I'll take a close look at v4.

J
> 
> Alistair
> 
> >  
> > > +        }
> > > +
> > > +        Ok(rsp)
> > > +    }
> > > +}  
> >  

