Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4C37F727
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518528; cv=none; b=Q6l0Qe/aQnuhg1b8+YHK+EHsYGbQFjyCCDvqBtIcL/FBsIqASXPl41cpVa4laGRLnKYy6ZT+DOkLHiVF39WIM+2ZFJUEp/YG/dXuWwTk/LRmbVVpz6zRxuDB5yFHNFnJFtvlOljQnrKjg2H9Vm2D+QWoUrx5n5crQgKsz6ipzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518528; c=relaxed/simple;
	bh=/OWJXGJs8SSkmcHPkdwWCPWcLueZZf5qaZwsy+85OT4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=mBXGtRBP/djLqSUcMSOwAvEmV7hVRBq0ENfw9bEq+XpFBhH+ZNrV05IQMbsHQ3HPUGyfskpqF3j6fI8r0BEEJXZup0cPxH7vYrKu/rydMRFm9231TQ19VEHzRP56asGXOddOAcjYImmUdovCZ9FI/IINDQhQU+f0b53nJAsBOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqaWHgcH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqaWHgcH"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeba09900bso605669e87.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518525; x=1784123325; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pMIZknUnUy6XFCDmMjtt4ptvm8FYoUm42a75htqi/WM=;
        b=PqaWHgcH/WsLwMtC6jbMSngMIwuFGxfZ/zykw0VvpU3yCHJJNjR32ASq+PWUOKI7If
         YxGbHqavP0jKmZ/SNm5PJKgPGRl+yvBd/CYFJWVF7O6QzrgzkwMweKjzin17W33yumKO
         a9iWR8seBPfTg9IzT2miG82VHdG5cOiNp2VBj7yNqJj2e/6ceu4TE+wytZIJ5HgZGBmR
         xOGCaZpXs4122peaADyjD+iLOfXInKGvYMltfkZYGYp5gh/Vpv10EXpfeUVwNiJe0II6
         ux5oU8z2AOB+3TFx+jB15LtLUYriIiCGw/4TCnujEs6aYksRNY7Rga/2sXFANScyYs8a
         0IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518525; x=1784123325;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pMIZknUnUy6XFCDmMjtt4ptvm8FYoUm42a75htqi/WM=;
        b=ex2dhBhsVJrP2SdrTo/+bHSZThiigXmxJMlMQWoNYyTRatlZh+oNf7xq/JU1jnxgrc
         f0308RZO0yK2xxQ11gtSvb/jGw1PQk6d/QazfvTEDehLMU0n3wobab2CnadyyFHMS97m
         0o1XUhGBjBkPzuu43puUYYHNqYc+cjUYIoFBmGDWy0ivYRl8qsNigGlm1AJFXIi/6KI4
         bQXAzA3p2AJFGyuIe2Wnvv0dWHZUmfDmC58R/H1Buup+px82Pw7GJ8WFFn9iIFubj+1f
         AKVxnGn6d46RtYPTj+FPRFgl1zRmlbv5SpG3/k/IXiZOnnLhZAdYa/JRHGgeSclU2Lia
         +yyw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2cnXmNUkuRhnZwV5mYItUnbS6xtmJRZ7bAmfqfOJSyf9BPBaegwDGhtqJgD6XbadFlv4QAI25wMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyraHhrw+hUXQL65BeMJg/N5k2tADfSyu5DeWiUCSoxEupHximC
	vTBT8CpFqoMeXsJPrmzeZ7MpSAOWNqzGTWa4QGg5k1ANEYOsD62w1EZy
X-Gm-Gg: AfdE7cm8lV+SUBXmhvIzMj8H8QRty+dBlUV70k/JQEu322HOdRilZTW0XMCNN/ioKYr
	9//USU0I+vYqs/dNy/KEkCIITno9/UBM5qofeuR0WYTfuMhWj3+HD8v3OaQ5NjnZvROMu8Ke+i5
	R2/EwY1ItB9pm2rDEdmlqjfambuSqU4l+ZAJ/HfdH9vodLZpXjfBWr0LDwyJl2OTcq6ftOUEekY
	wc5ysBCCi8bysL/rtRn8Xv2A6qQwFfn7x7Wv0nWLA5x6530XITPgNry9CI7mg7yPGE51sIQQ9sq
	byInWkpAwjoK7Jsy4NLXHGPcRZu6C6J5QdAYwijYNbV05hHIpaIin9iN1B/CE/9ZOGDK8rGxSYQ
	SbSgQmbZM8UVJBExNB2Vn0VQPlhlreFuOc2aJg1PsrmerAqaKO6AcsiDKTBXvIzdi7GGK3qgYys
	ULqm4jLOZ6HmCeQDCN+RgKUHYI/7HO6g==
X-Received: by 2002:a05:6512:6205:b0:5b0:eda:de1b with SMTP id 2adb3069b0e04-5b0114440f8mr751542e87.16.1783518525235;
        Wed, 08 Jul 2026 06:48:45 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:eccc:7ea2:9458:892d])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b4ad3614fsm31087491fa.12.2026.07.08.06.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:48:44 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev,  linux-pci@vger.kernel.org,
  driver-core@lists.linux.dev,  ankita@nvidia.com,  Alistair Francis
 <alistair.francis@wdc.com>,  Lukas Wunner <lukas@wunner.de>,  Jakub
 Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 02/15] tools: ynl: Teach pyynl to handle blobs
In-Reply-To: <20260705220819.2472765-3-djbw@kernel.org>
Date: Wed, 08 Jul 2026 14:48:28 +0100
Message-ID: <m2ldblbnir.fsf@gmail.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<20260705220819.2472765-3-djbw@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <djbw@kernel.org> writes:

> The generic "device evidence" facility wants to convey large objects
> (certificate chains, measurements) and support various security commands
> relative to that evidence (like validate) [1].
>
> Update pyynl to understand the "bloblen" property indicates:
> * the associated attribute is a variable length byte array
> * it is multi-attr where each message with the same attribute represents
>   chunks of the byte array
> * the byte array's size is conveyed in a scalar attribute named by the
>   "bloblen" property.
> * the attribute identified by "bloblen" always arrives in a message before
>   the first chunk of the associated blob
>
> A "multi-attr" without "bloblen" retains the legacy behavior where repeated
> reception of the same attribute across messages results in a new instance
> of the object. The new behavior causes repeated reception of an
> attribute to be treated as filling consecutive bytes of an array.
>
> Assisted-by: Codex:GPT-5
> [codex: drafted initial python changes]
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>  tools/net/ynl/pyynl/lib/nlspec.py | 12 ++++++
>  tools/net/ynl/pyynl/lib/ynl.py    | 62 ++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 2 deletions(-)

I am mid-review of this but I think it could be simplified. See initial
thoughts below. Can you show me how to configure a test env so I can try
it out?

>
> diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
> index 0469a0e270d0..4764263968ea 100644
> --- a/tools/net/ynl/pyynl/lib/nlspec.py
> +++ b/tools/net/ynl/pyynl/lib/nlspec.py
> @@ -172,6 +172,7 @@ class SpecAttr(SpecElement):
>          selector      string, name of attribute used to select
>                        sub-message type
>  
> +        bloblen       string, name of attr which reports the blob length
>          is_auto_scalar bool, attr is a variable-size scalar
>      """
>      def __init__(self, family, attr_set, yaml, value):
> @@ -181,6 +182,7 @@ class SpecAttr(SpecElement):
>          self.value = value
>          self.attr_set = attr_set
>          self.is_multi = yaml.get('multi-attr', False)
> +        self.bloblen = yaml.get('bloblen')
>          self.struct_name = yaml.get('struct')
>          self.sub_type = yaml.get('sub-type')
>          self.byte_order = yaml.get('byte-order')
> @@ -191,6 +193,10 @@ class SpecAttr(SpecElement):
>  
>          self.is_auto_scalar = self.type in ("sint", "uint")
>  
> +        if self.bloblen and not self.is_multi:
> +            raise SpecException(
> +                f"Attribute '{attr_set.name}.{self.name}' has bloblen without multi-attr")
> +
>  
>  class SpecAttrSet(SpecElement):
>      """ Netlink Attribute Set class.
> @@ -355,6 +361,8 @@ class SpecOperation(SpecElement):
>          attr_set        attribute set name
>          fixed_header    string, optional name of fixed header struct
>  
> +        dump_blob_attrs set, reply blob attribute names which may span messages
> +
>          yaml            raw spec as loaded from the spec file
>      """
>      def __init__(self, family, yaml, req_value, rsp_value):
> @@ -369,6 +377,7 @@ class SpecOperation(SpecElement):
>          self.is_async = 'notify' in yaml or 'event' in yaml
>          self.is_resv = not self.is_async and not self.is_call
>          self.fixed_header = self.yaml.get('fixed-header', family.fixed_header)
> +        self.dump_blob_attrs = frozenset()

Initialising to None would avoid some other logic.

>  
>          # Added by resolve:
>          self.attr_set = None
> @@ -388,6 +397,9 @@ class SpecOperation(SpecElement):
>              raise SpecException(f"Can't resolve attribute set for op '{self.name}'")
>          if attr_set_name:
>              self.attr_set = self.family.attr_sets[attr_set_name]
> +            reply_attrs = self.yaml.get('dump', {}).get('reply', {}).get('attributes', ())
> +            self.dump_blob_attrs = frozenset(
> +                name for name in reply_attrs if self.attr_set[name].bloblen)
>  
>  
>  class SpecMcastGroup(SpecElement):
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index 092d132edec1..f21b68043bd3 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -998,6 +998,47 @@ class YnlFamily(SpecFamily):
>          else:
>              rsp[name] = [decoded]
>  
> +    def _blob_fill(self, buf, off, chunks, name):
> +        for chunk in chunks:
> +            end = off + len(chunk)
> +            if end > len(buf):
> +                raise YnlException(f"Blob '{name}' data exceeds reported length")
> +            buf[off:end] = chunk
> +            off = end
> +        return off
> +
> +    def _blob_init(self, op, rsp, blob_attrs):
> +        """
> +        Start a new blob object. Preallocate each blob payload using the
> +        length carried ahead of the data and copy in the first chunk(s).
> +        Return the per-attribute write offsets for any following messages.
> +        """
> +        offsets = {}
> +        for name in blob_attrs:
> +            if name not in rsp:
> +                continue
> +            length = rsp.get(op.attr_set[name].bloblen, 0)
> +            buf = bytearray(length)
> +            offsets[name] = self._blob_fill(buf, 0, rsp[name], name)
> +            rsp[name] = buf
> +        return offsets
> +
> +    def _blob_extend(self, rsp, update, blob_attrs, offsets):
> +        """
> +        Continue filling the previous object's blob(s) when the current
> +        message carries only blob continuation attributes.
> +        """
> +        if any(name in rsp and name not in blob_attrs for name in update):
> +            return False
> +
> +        for name, value in update.items():
> +            if name in blob_attrs and name in rsp:
> +                offsets[name] = self._blob_fill(rsp[name], offsets.get(name, 0),
> +                                                value, name)
> +            else:
> +                rsp[name] = value
> +        return True
> +
>      def _resolve_selector(self, attr_spec, search_attrs):
>          sub_msg = attr_spec.sub_message
>          if sub_msg not in self.sub_msgs:
> @@ -1356,7 +1397,10 @@ class YnlFamily(SpecFamily):
>          for (method, vals, flags) in ops:
>              op = self.ops[method]
>              msg = self._encode_message(op, vals, flags, req_seq)
> -            reqs_by_seq[req_seq] = (op, vals, msg, flags)
> +            blob_attrs = None
> +            if Netlink.NLM_F_DUMP in flags:
> +                blob_attrs = op.dump_blob_attrs or None
> +            reqs_by_seq[req_seq] = (op, vals, msg, flags, blob_attrs)

I think this hunk can be dropped and instead use op.dump_blob_attrs directly

>              payload += msg
>              req_seq += 1
>  
> @@ -1365,6 +1409,7 @@ class YnlFamily(SpecFamily):
>          done = False
>          rsp = []
>          op_rsp = []
> +        blob_off = {}
>          while not done:
>              reply, ancdata = self._recvmsg()
>              nsid = self._decode_nsid(ancdata)
> @@ -1372,13 +1417,14 @@ class YnlFamily(SpecFamily):
>              self._recv_dbg_print(reply, nms)
>              for nl_msg in nms:
>                  if nl_msg.nl_seq in reqs_by_seq:
> -                    (op, vals, req_msg, req_flags) = reqs_by_seq[nl_msg.nl_seq]
> +                    (op, vals, req_msg, req_flags, blob_attrs) = reqs_by_seq[nl_msg.nl_seq]
>                      if nl_msg.extack:
>                          nl_msg.annotate_extack(op.attr_set)
>                          self._decode_extack(req_msg, op, nl_msg.extack, vals)
>                  else:
>                      op = None
>                      req_flags = []
> +                    blob_attrs = None
>  
>                  if nl_msg.error:
>                      raise NlError(nl_msg)
> @@ -1388,6 +1434,11 @@ class YnlFamily(SpecFamily):
>                          print(nl_msg)
>  
>                      if Netlink.NLM_F_DUMP in req_flags:
> +                        if blob_attrs:
> +                            for obj in op_rsp:
> +                                for name in blob_attrs:
> +                                    if isinstance(obj.get(name), bytearray):
> +                                        obj[name] = bytes(obj[name])
>                          rsp.append(op_rsp)
>                      elif not op_rsp:
>                          rsp.append(None)
> @@ -1414,6 +1465,13 @@ class YnlFamily(SpecFamily):
>                  rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
>                  if op.fixed_header:
>                      rsp_msg.update(self._decode_struct(decoded.raw, op.fixed_header))
> +
> +                if blob_attrs:
> +                    if op_rsp and self._blob_extend(op_rsp[-1], rsp_msg,
> +                                                    blob_attrs, blob_off):
> +                        continue
> +                    blob_off = self._blob_init(op, rsp_msg, blob_attrs)
> +

This approach seems unnecessary for pyynl. Just let multi-attr do its
thing and then concatenate them at the end.

>                  op_rsp.append(rsp_msg)
>  
>          return rsp
