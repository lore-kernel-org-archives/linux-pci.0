Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234F253958
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289934; cv=none; b=BSKSdoTIKSlaujYM2Cl5jjCGTB+Q0Xr8j6mR3AqZxAfCPm/SGRpn9gfeqEhSjzIG06zRMCKNDGqxwsLcwc6+WzGklb/V22U9nozk4Nrt4qL6NWc3DBd47J400thmuUiPtTvmmdTqyhjYc3VbotsbylAkTd5UiXmzRXBVVNxj14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289934; c=relaxed/simple;
	bh=Z6tcdgGgvyGNOO7OwPmHZXI9mSqMNGpk8TyYdBcBCc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NjdL8IphNYbL4/m5CsT3r3LExA9U/CcgANR/anyx0RfHE8k6pYOiPmHAkfUkVzY/m8kzMc6ZFA5dmFNBh8akIju4RFMpNx7W3mss0qprZr0znrFGYhE8DcsmGostZjbRJ+5KDSAhYmPBbQZLQkjqKhkbvofk6/QwjGxc63KMY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBXAbzK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBXAbzK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A341F000E9;
	Sun,  5 Jul 2026 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289933;
	bh=FIlXdWeYq0owvDKszx1FxfN2pCTq7VOhfPl1V9fmzCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iBXAbzK3SOav4p5wVCsi4MMKxQw9Dthisqfoy6u2CCORTmyWJKJg8Y4Ojoh98mpxg
	 SgaoJa30pwkhfBFSuwlQftXAo9GvrIK4aTHp1Ko48Vm/+//0CGQJc2ZrtJhhRTx/CK
	 dy55yUinR2kOEfQLGH6ylK3+9Qg6qS6487OJshvC0+XSHjINFF1q8q6HlghubkBM/L
	 sQg9Yo3EWDS7TozqwaIg66mmHtijNzGDZ59D2OGZ4kcYD6xQxn1RFAwslZho3PO0Aa
	 RR6br2SbrZKx6iw9iZrWPA95yCrOr7higFOZlxgeZ8EPX+2ieWXAK2bfBLLCCwNmnr
	 kRHEkOGnX/Zxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] tools: ynl: Teach pyynl to handle blobs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-3-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-3-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:18:52 +0000
Message-Id: <20260705221853.08A341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] _blob_extend incorrectly rejects continuation messages and treat=
s them as new objects if they contain repeated scalar attributes (e.g., obj=
ect identifiers).
- [Medium] PyYNL crashes with a false length exception or type error if a b=
lob's first chunk arrives in a continuation message instead of the initial =
message.
- [Low] Blob attribute coalescing is restricted exclusively to dump operati=
ons, causing 'do' operations to inconsistently return lists of chunks.
--

commit 6f54aff032c9d8543801051eb2d44c4da3645009
Author: Dan Williams <djbw@kernel.org>

tools: ynl: Teach pyynl to handle blobs

This commit updates pyynl to handle blobs by supporting the "bloblen"=20
property, where multiple messages with the same attribute represent chunks=
=20
of a byte array. It coalesces these chunks into a single byte array=20
instead of treating them as separate objects.

Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]

> diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/=
nlspec.py
> index 0469a0e270d05..4764263968ea6 100644
> --- a/tools/net/ynl/pyynl/lib/nlspec.py
> +++ b/tools/net/ynl/pyynl/lib/nlspec.py
[ ... ]
> @@ -388,6 +397,9 @@ class SpecOperation(SpecElement):
>              raise SpecException(f"Can't resolve attribute set for op '{s=
elf.name}'")
>          if attr_set_name:
>              self.attr_set =3D self.family.attr_sets[attr_set_name]
> +            reply_attrs =3D self.yaml.get('dump', {}).get('reply', {}).g=
et('attributes', ())
> +            self.dump_blob_attrs =3D frozenset(
> +                name for name in reply_attrs if self.attr_set[name].blob=
len)

[Severity: Low]
Is blob attribute coalescing meant to be restricted only to dump operations?
Since we only check the dump reply block here, a 'do' operation returning a
multi-attr blob will bypass the coalescing logic entirely and return a list
of bytes chunks instead of a single contiguous bytes object.

> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl=
.py
> index 092d132edec12..f21b68043bd3c 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
[ ... ]
> @@ -998,6 +998,47 @@ class YnlFamily(SpecFamily):
>          else:
>              rsp[name] =3D [decoded]
> =20
> +    def _blob_fill(self, buf, off, chunks, name):
> +        for chunk in chunks:
> +            end =3D off + len(chunk)
> +            if end > len(buf):
> +                raise YnlException(f"Blob '{name}' data exceeds reported=
 length")
> +            buf[off:end] =3D chunk
> +            off =3D end
> +        return off
> +
> +    def _blob_init(self, op, rsp, blob_attrs):
> +        """
> +        Start a new blob object. Preallocate each blob payload using the
> +        length carried ahead of the data and copy in the first chunk(s).
> +        Return the per-attribute write offsets for any following message=
s.
> +        """
> +        offsets =3D {}
> +        for name in blob_attrs:
> +            if name not in rsp:
> +                continue

[Severity: Medium]
Could this lead to a false length exception or type error if a blob's first
chunk arrives in a continuation message instead of the initial message?

If the initial message contains the bloblen attribute but no data chunks,
_blob_init() skips initializing the buf for that attribute here.

When the first chunk arrives in a subsequent message, _blob_extend() will
fall into its else branch and assign the raw decoded value (a list of byte
chunks) directly to rsp[name].=20

If a third message arrives with more chunks, _blob_extend() passes this list
as buf to _blob_fill(). The call to len(buf) will evaluate to the number of
chunks rather than the byte length, incorrectly triggering the "exceeds
reported length" exception.

> +            length =3D rsp.get(op.attr_set[name].bloblen, 0)
> +            buf =3D bytearray(length)
> +            offsets[name] =3D self._blob_fill(buf, 0, rsp[name], name)
> +            rsp[name] =3D buf
> +        return offsets
> +
> +    def _blob_extend(self, rsp, update, blob_attrs, offsets):
> +        """
> +        Continue filling the previous object's blob(s) when the current
> +        message carries only blob continuation attributes.
> +        """
> +        if any(name in rsp and name not in blob_attrs for name in update=
):
> +            return False

[Severity: Medium]
Does this logic incorrectly reject continuation messages and treat them as
new objects if they contain repeated scalar attributes?

When the kernel sends a continuation message in a dump, it typically
includes the object's identifying keys (like dev-id) alongside the blob
chunks. The above check will evaluate to True for these keys because they
are already in rsp (from the first message) and are not blob attributes.

This causes _blob_extend() to return False, treating the continuation
message as a new object and splitting the blob. Would it be better to
verify if the overlapping key values actually differ?

> +
> +        for name, value in update.items():
> +            if name in blob_attrs and name in rsp:
> +                offsets[name] =3D self._blob_fill(rsp[name], offsets.get=
(name, 0),
> +                                                value, name)
> +            else:
> +                rsp[name] =3D value
> +        return True
[ ... ]
> @@ -1356,7 +1397,10 @@ class YnlFamily(SpecFamily):
>          for (method, vals, flags) in ops:
>              op =3D self.ops[method]
>              msg =3D self._encode_message(op, vals, flags, req_seq)
> -            reqs_by_seq[req_seq] =3D (op, vals, msg, flags)
> +            blob_attrs =3D None
> +            if Netlink.NLM_F_DUMP in flags:
> +                blob_attrs =3D op.dump_blob_attrs or None

[Severity: Low]
Is there a reason blob attribute coalescing is explicitly disabled if the
request is not a dump operation? This seems to restrict do operations from
returning coalesced blobs, making them fall back to returning lists of
chunks.

> +            reqs_by_seq[req_seq] =3D (op, vals, msg, flags, blob_attrs)
>              payload +=3D msg
>              req_seq +=3D 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D2
