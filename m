Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660786;
	b=w9309LfwX4RD2jfJ44bxo4nXNYRUSrgVP7Coo6VvgwxKPGTXednudN6mZrY2Ucbvlvvu
	 6Iu44mq5rOaVqaRtkPxuMTKP2JwU0Lybocy0NYkHzQ41KDpw66CSpgc56CG4+0+1NYRIg
	 IhE2zSqg7FYuryzLR5TBOhytutRaE2qSntESevQ2KnOCiLD2q0uLmQAXu0AuPP8Iif/5A
	 rlren6ne5aXD6zT6lqhtemTeOFtjbD/s3n3dUjDMwCzJXCznBZofUaV//MtEjA49JmA59
	 MVVQ9o4bq47XcpMl3FaftuOPPsZtz9uwTv4FDBpgT1QfKFx07RssFnCAt7JQlaTnQjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660786;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=adIUxbBUAhPoTEgVJ2ZdQQ0sIkUjRLbD7ye6beWxzTc=;
	b=f2vSFgl0gr6+7OuhdfwC+rtg15N23DYKxmG4kPTj33Xj/cuUJdNkEQm6u4S095KO0gcn
	 KWdACu05ja9s3ftRnNYHARzUXIDgX8qBqKkDWohI9z4QZDYsaXwcg/IPa24C/q2yHw5w5
	 SKOY6z1qj4UINHCrxIyddf8pwpRHPez5igzG97Ed6iV8u8w36OGiaESuSSsGCLJ5c8ovj
	 CFCjUu6UuXnjdTUUXU90ljvEIBn+Dum4cDX9I1nbk31vbuP09fnEVFigtvXW9jovcTzN2
	 0cej/6gaTLY0PzPzmxZH+4MBH9/LD/k6ENUD48UD0nXha68u9fxzUgxBPXUH+gBLx2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojb3Czh8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CF606A324;
	Mon,  2 Nov 2026 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojb3Czh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F21F00A16;
	Mon,  2 Nov 2026 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660785;
	bh=adIUxbBUAhPoTEgVJ2ZdQQ0sIkUjRLbD7ye6beWxzTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ojb3Czh8KMIoL/VvdgllPD/Rn4ll3vpd8bSHNaVcp9Gk0+6ToD6NDryr4AR11vpi1
	 XUxes3z4YCAm3nOVrM3z7fdOjZ+HdIJ58YE/s2Bvb3wYsSit40e6UpvA6SIWF3sftX
	 Jc3/DQgmwFDC5HZv5EWJ0QdlR3mDmib6RntK/oytFM9qo31kP5HL6/YpxOxRsFiyEb
	 YKTj6bbE/tAD2kBNwtfYEJPKAnI40oa2cJi9+zwtSQdFyTroKpSGQHcGuNo68X+NyM
	 mmbQ8UKB15V9j5BA3mPSpinaIx19MwiqSRLws1EJRYkagmH16Q9QXcp38qBD646Zhd
	 Jwbd2cKRXDFHQ==
Date: Mon, 2 Nov 2026 17:06:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com,
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com,
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com,
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de,
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com,
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org,
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com,
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
	schnelle@linux.ibm.com, skhan@linuxfoundation.org,
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com,
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct
 pci_saved_state
Message-ID: <20261102230624.GA1038787@bhelgaas>
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
In-Reply-To: <20261102153656.1431701-6-vipinsh@google.com>

On Mon, Nov 02, 2026 at 07:36:34AM -0800, Vipin Sharma wrote:
> Drivers that keep a device running across Live Update need to hand the
> state they captured with pci_store_saved_state() to the next kernel,
> since the next kernel never sees the device in that state. VFIO, for
> example, captures it at first open and uses it to restore the device
> when the last user closes it.
> 
> struct pci_saved_state is private to the PCI core and its in-memory
> layout is not a stable ABI. Add helpers to serialize it into a
> caller-provided buffer and rebuild it in the next kernel with a stable
> struct pci_saved_state_ser ABI. Using caller-provided buffers allows
> drivers to embed the serialized saved state directly in their own
> KHO-preserved data with a single allocation and lifetime.
> 
> Validate the serialized buffer and verify that the saved standard
> configuration header matches the live device before rebuilding the
> state: the vendor and device IDs must match, only Type 0 (Normal)
> headers are accepted, and BAR0-5 and the expansion ROM BAR address must
> equal the current hardware values. This ensures that restoring the
> saved state cannot write stale BAR addresses if resources were
> reassigned in the new kernel. Only the address bits of the ROM BAR are
> compared, since its enable and validation status bits may legitimately
> differ.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

A few nits below.

> +static const struct pci_cap_saved_data *pci_saved_cap_next(const struct pci_cap_saved_data *cap)
> +{
> +	return (const void *)cap + sizeof(*cap) + cap->size;
> +}
> +
> +/**
> + * pci_liveupdate_saved_state_ser_size() - Size needed to serialize a saved state

Wrap to fit in 80 columns (75 or so is even nicer because it's a
little more relaxed to read and typo fixes are less likely to rewrap).

> + * @state: Saved state returned by pci_store_saved_state(), or NULL.
> + *
> + * Return: Number of bytes needed by pci_liveupdate_serialize_saved_state(), or
> + * 0 if @state is NULL.
> + */
> +size_t pci_liveupdate_saved_state_ser_size(const struct pci_saved_state *state)

I think pci_liveupdate_saved_state_ser_size() is connected with
pci_liveupdate_serialize_saved_state() and
pci_liveupdate_deserialize_saved_state().

Would be nice if that were obvious from the names.

They're also pretty long, which makes prototypes and uses very likely
to wrap in awkward spots.

> + * struct pci_cap_saved_data_ser - A saved capability in a struct pci_saved_state_ser
> + * @cap_nr: Capability ID (PCI_CAP_ID_* or PCI_EXT_CAP_ID_*).
> + * @extended: 1 if @cap_nr is an extended capability ID, 0 otherwise.
> + * @size: Size of @data in bytes, never 0.
> + * @data: The saved registers.
> + */
> +struct pci_cap_saved_data_ser {
> +	u16 cap_nr;

Maybe "cap_id" to avoid confusion with "nr_caps" or indexes into
"caps[]" below?

> +	u16 extended;
> +	u32 size;
> +	u8 data[];
> +} __packed;
> +
> +/**
> + * struct pci_saved_state_ser - Serialized struct pci_saved_state
> + * @size: Size in bytes of this struct, including all entries in @caps.
> + * @flags: Features a kernel must support to restore the state. None defined.
> + * @nr_caps: Number of entries in @caps.
> + * @config_space: The saved standard configuration header.
> + * @caps: @nr_caps struct pci_cap_saved_data_ser entries.
> + */
> +struct pci_saved_state_ser {
> +	u32 size;
> +	u32 flags;
> +	u32 nr_caps;
> +	u32 config_space[16];
> +	u8 caps[];

I think it would be helpful if the names of "config_space[]" and
"caps[]" hinted at the connection between them (both are in config
space).  "config_space[]" by itself suggests it's complete, which it's
not, so maybe there's a place for "hdr" or similar in it.
