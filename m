Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D434DCC8
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290037; cv=none; b=RYP9XgKR3Q9qorCuASlPIW/1PwPgcjzPf1LUNAyHu/HQ26rJjEXslBJZstR4W2OB6594u27HX04yik++uOGOYVhipdBP2hUgESUKHmkeQdolYyG5GlVZctgBP/idGG8401hP0e58CA6xTUmFrFCS6rxuZOthlqWzS+22uXgMdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290037; c=relaxed/simple;
	bh=RNxydmnS56y8YWvjGsDM48OBwNppd3zfpP/5jYW7LlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXcMRE1vmse5/pWfbl/wJZ+oWCSqACrtkmRT6QnHMRaWWXnRxfrv75MDkVcxguOMX1ReaJLIO1Ejwx2tl8oj4p9ycgjJI/ZdE0kLPD8thQJOGZqWYcgQYuMUdsxwoJcHUL4wzL5ZWQjcTyeWuh91XWq+ysKULx4Mnx/4Mv1i0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aePWzN9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aePWzN9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE381F000E9;
	Sun,  5 Jul 2026 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290035;
	bh=pJrOuyAupzyaFs9AT0gjEzDd34+b1EmuEJhVd6XGpwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aePWzN9jNXQHQZZPhXFtJ2viprVJslf4pa8Y3L3Z8Jre/jGf2R3Pf3FN6y/fFE+4G
	 4f3nHCcHHzMPLhGepBJxvX8Xl6GMrxGITEX56xTnpmSCd3cuBHS2HBG5iu8TMqaNUv
	 Ej+fxqMUVUnNCpVaYPKMty0Dr5usePvGlnTfqEsgHCuSB5gfyQAeg6Tsk0TzFVUga9
	 dBLjRLPdH+fAggZpxVlGjHZqUmQ0mi54f0ehzDzcBDVBjSY5g2CvBrFVCqeYbhkuSI
	 qPHi0+ezeH9WTSzb/L8U6OPXbfYvSrV/WR+o/Yctn49rJvk3pI3AnWBZj9B7BO+ec3
	 bGWWgIhDJ0DgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] tools: ynl: Teach ynl_gen_c to validate and dump
 'blob' attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-4-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-4-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:20:34 +0000
Message-Id: <20260705222035.5EE381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The generated `_more()` function fails to coalesce blob chunks if =
the length attribute arrives in a message prior to the blob data, breaking =
multi-message coalescing.
- [High] The generated C setter function for blobs lacks a NULL check for `=
malloc` and is vulnerable to integer overflow on 32-bit systems, causing me=
mory corruption or crashes.
- [High] Request serialization (`attr_put`) does not support chunking large=
 blobs, leading to silent data corruption due to 16-bit `nla_len` truncatio=
n if the blob exceeds 64KB.
- [Medium] `ynl_exec` fails to check for incomplete blobs, leading to silen=
t data truncation for `do` commands.
--

commit 5e458f41fb05443af96a2ab1a2945032cdac2de5
Author: Dan Williams <djbw@kernel.org>

tools: ynl: Teach ynl_gen_c to validate and dump 'blob' attributes

Now that blobs are recognized by pyynl and coalesced over successive
netlink messages, do the same for the generated C. Recall that blobs
support large objects for protocols like SPDM.

Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]

> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index 2bcd781111d74..933ee0ad2c51d 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
[ ... ]
> @@ -1059,6 +1087,11 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlms=
ghdr *req_nlh,
>  			goto err_close_list;
>  	} while (err > 0);
> =20
> +	if (ynl_check_more(yds)) {
> +		yerr(ys, YNL_ERROR_ATTR_MISSING, "Dump ended with an incomplete blob");
> +		goto err_close_list;
> +	}

[Severity: Medium]
While ynl_exec_dump() verifies that the blob is complete here, does ynl_exe=
c()
for single command responses completely omit this validation?

If the kernel returns a response where the provided blob data is shorter
than the advertised length, will the parser silently succeed and leave
userspace with a truncated blob?

Should struct ynl_req_state also include a more callback?

> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_g=
en_c.py
> index cdc3646f2642c..f0387004b7ccf 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
[ ... ]
> @@ -791,6 +818,10 @@ class TypeMultiAttr(Type):
>              put_type =3D self.type
>              ri.cw.p(f"for (i =3D 0; i < {var}->_count.{self.c_name}; i++=
)")
>              ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {va=
r}->{self.c_name}[i]);")
> +        elif self.attr['type'] =3D=3D 'binary' and self.is_blob():
> +            ri.cw.p(f"if ({var}->{self.c_name})")
> +            ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, " +
> +                    f"{var}->{self.c_name}->data, {var}->{self.c_name}->=
len);")

[Severity: High]
Does ynl_attr_put() support chunking blobs larger than 64KB?

If a user application attempts to send a blob larger than 65531 bytes, it
appears nla_len will overflow its 16-bit capacity in ynl_attr_put():

    attr->nla_len =3D NLA_HDRLEN + size;
    memcpy(ynl_attr_data(attr), value, size);
    nlh->nlmsg_len +=3D NLMSG_ALIGN(attr->nla_len);

Will nlmsg_len then advance incorrectly while memcpy() copies the full data,
causing subsequent attributes to overwrite the middle of the blob?

[ ... ]
> @@ -805,6 +836,10 @@ class TypeMultiAttr(Type):
>              raise Exception(f"Put of MultiAttr sub-type {self.attr['type=
']} not supported yet")
> =20
>      def _setter_lines(self, ri, member, presence):
> +        if self.is_blob():
> +            return [f"{presence} =3D {self.c_name}->len;",
> +                    f"{member} =3D malloc(sizeof(*{member}) + {presence}=
);",
> +                    f"memcpy({member}, {self.c_name}, sizeof(*{member}) =
+ {presence});"]

[Severity: High]
Does this generated C code lack a NULL check for the malloc() return value?

If malloc() fails, the returned NULL pointer will be passed directly to
memcpy(), potentially causing a crash.

Additionally, on 32-bit systems, could sizeof(*member) + presence result in=
 an
integer overflow if the length is large? If the addition wraps around, it
might allocate a small buffer while leaving the length field corrupted.

[ ... ]
> @@ -2388,6 +2424,33 @@ def parse_rsp_msg(ri, deref=3DFalse):
>          ri.cw.nl()
> =20
> =20
> +def _blob_attrs(ri):
> +    return [attr for _, attr in ri.struct['reply'].member_list() if attr=
.bloblen]
> +
> +
> +def print_rsp_more(ri):
> +    blob_attrs =3D _blob_attrs(ri)
> +    if not blob_attrs:
> +        return
> +
> +    local_vars =3D [f'{type_name(ri, "reply", deref=3DTrue)} *rsp =3D da=
ta;']
> +
> +    ri.cw.write_func_prot('static bool',
> +                          f'{op_prefix(ri, "reply", deref=3DTrue)}_more',
> +                          ['void *data'], suffix=3D'')
> +    ri.cw.block_start()
> +    ri.cw.write_func_lvar(local_vars)
> +
> +    for attr in blob_attrs:
> +        ri.cw.p(f"if (rsp->{attr.c_name} && " +
> +                f"rsp->_len.{attr.c_name} < rsp->{attr.c_name}->len)")
> +        ri.cw.p('return true;')

[Severity: High]
If the blob length attribute arrives in a netlink message prior to the blob
data message, will the blob pointer still be NULL?

If the blob is NULL, this function will return false. Would that cause
ynl_dump_trampoline() to fall through and allocate a new object instead of
coalescing the data, dropping the previously parsed length?

When the next message with the data chunk arrives, wouldn't it allocate a
0-length blob and fail with a "blob data exceeds length" error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D3
