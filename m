Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C54CDDFE
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662391; cv=none; b=YB4lw8HJu1wuK8INn8hq8NxbTm/YyDxavWul/rDKQJPRG1Gh4A6Xmc6cUo6M86gzxAP2lo84Jm/ImEp+YmxFSLdp1NR31ar29NGEaELoX/PyTOCv4JToun+rFXIi+FAmafKXXRZ439GJ6KloSshbqIQnuSpbYQIeoUJZS6GkbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662391; c=relaxed/simple;
	bh=/XgH+kfKjSbpzJY4yqsQlS1h/feiybtMRwm/CFGgspY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jhcvp5XlX7m2dpX6yM6spDEuU0LETPhwuZEcy7I2RLem0hYOVQdBYYUDUjsHiRVty+ZHRtobaCd2FAg6KgvCP7tD+Gq5vVz5T+SbJ4BCXqaJYi3kN1njKwh0x/IkPrvgtps5tUF95hd+dApEkvUw34AiSXfhATcTrymcYDvFEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=lmR+hMCR; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="lmR+hMCR"
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HFaLMM2428978;
	Thu, 17 Sep 2026 17:17:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=apr2026.eng;
	 bh=f/P17vLNhgAuXOGXoNhfPybBk9DMrjo/FfMTRcHe0VQ=; b=lmR+hMCRHQOX
	1MqG7aFoH0rIZ4rL10gshnzM/MyXqOqDckjI4ylFaCJ9VnYxv/+RyqfVEAHhQzx3
	I6gvzSwKvKl2YE93TJ+wk6ajdITznofjKiU8M/I+DjUw87xDwQ28Fl9NpjMrUA4r
	HrfEtPed3fWQiVT4jwtELVtYu0pFeuPHD9vktwCJX+ru3o0DqCmrstB6byvC20oG
	qOvZjMHYe6cJEalHYjldg4OJPV3ZtEI00R2+piw1mCfSO/6Maalnsad/bcL7BVis
	XU6k4AKLPdjO+0gFUP3xYQYrRd6ZoJNVXcZGyvSsDCUXLqddtm8NMEQDy++7q1j2
	pK8DZvfX9A==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4gp29qd532-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:17:05 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 68HG6HtX029316;
	Thu, 17 Sep 2026 09:17:04 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4gn4q7urp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 09:17:04 -0700 (PDT)
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 17 Sep 2026 09:17:03 -0700
Received: from bos-lpnz1z1y (172.27.118.139) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.43 via Frontend Transport; Thu, 17 Sep 2026 09:17:03 -0700
Received: by bos-lpnz1z1y (Postfix, from userid 56609)
	id 29C5E241CAB; Thu, 17 Sep 2026 12:17:03 -0400 (EDT)
From: jlefkowi <jlefkowi@akamai.com>
To: <linux-pci@vger.kernel.org>
CC: <mj@ucw.cz>, <bchaney@akamai.com>, <mpelland@akamai.com>,
        jlefkowi
	<jlefkowi@akamai.com>
Subject: [PATCH 2/3] feature: add auto length discovery for vendor defined capabilities.
Date: Thu, 17 Sep 2026 12:16:30 -0400
Message-ID: <20260917161631.801636-3-jlefkowi@akamai.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917161631.801636-1-jlefkowi@akamai.com>
References: <20260917161631.801636-1-jlefkowi@akamai.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2609040000 definitions=main-2609170229
X-Proofpoint-GUID: oXhqPvm56iAw0UqX2F4YNJwTLVq5a93Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfX11MOd4hj94dv
 HJJQ3NP1Wx7h852P8DDv4DVc8V0lOifU07RtYiOH7TzAq0P1WUKHItJxNXZk9/eFDOig/cpZ75X
 xVTNPJA5mTeaBDj0gnAlDBGj6+hJb68=
X-Authority-Analysis: v=2.4 cv=Ud/E26SN c=1 sm=1 tr=0 ts=6aac1281 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=VcQvXEo1OZcA_IiPcy3B:22 a=X7Ea-ya5AAAA:8 a=hI7Ngbw4rNr3vCxiicwA:9
 a=P9hY669LYN7OhJm7:21
X-Proofpoint-ORIG-GUID: oXhqPvm56iAw0UqX2F4YNJwTLVq5a93Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfX6ISeszNgAlje
 MeOZGf+6DuU4s/iOMObSe03Cv53pWc5q99n2BENwjKpLdZS23lapMEMMcP8f61/nhpIvGtqZBxo
 ab3vawJx+Chpm1r8KxtqmUG9xjGFWijdCXxJleUpH508OYItEhVN2Nq04JCdv6OzbSgO2VXpswc
 /yAu59ha2fG+PLhU9LR2oG0FcN63ExvWVxc3l4X6MjTFUj4F5LCu5I9o5Zh7u+SVlKUqFi5NCX4
 1fncxlAI4sJ856aJcpQyRAUVBaTR9Jh0jmv8mT8Pjue7hhPtPHbC8m4XAQI5jV5efWJEQ9Gtyaz
 5qdWbkZ61ylBG8QTgPc5OTpm5ScI9UFhwNtF6INIfDvS54rrUOlpVkdf+SVBzaHpka01V8+V6T6
 jNgTO6Pk5r11fKK4N9Iu3TYc4HksdJILE0RYeTZkVa6UJx/i1RJ6iuyI9KiGzMh5sqzE6RhQlSc
 iqmj2OXzIGnjh0AyvNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170231

Update the variable length reading functionality to extend to .V syntax.
Such syntax expects for a variable-length vendor defined capability to be
provided as the target (such as ECAP_VNDR or ECAP_DVSEC).

When requested, setpci will dynamically, at runtime, read the header of the
specified capability, determine the length, store that within the span,
and manually upate the width accordingly, such that there are no torn reads.

The output of this request is in big-endian, and the reading semantics are
the same as variable length reads.

Signed-off-by: Jacob Lefkowitz jlefkowi@akamai.com
---
 setpci.c   | 169 +++++++++++++++++++++++++++++++++++------------------
 setpci.man |  25 ++++++--
 2 files changed, 133 insertions(+), 61 deletions(-)

diff --git a/setpci.c b/setpci.c
index 1b3476d..d492d9c 100644
--- a/setpci.c
+++ b/setpci.c
@@ -8,16 +8,18 @@
  *	SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include "lib/pci.h"
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
+#include <strings.h>
 
 #define PCIUTILS_SETPCI
 #include "pciutils.h"
 
-#define MAX_SPLIT_WIDTH 4 /* Has to be 1, 2, or 4 (valid singular pci read or write size) */
+#define MAX_OP_WIDTH 4        /* Has to be 1, 2, or 4 (valid singular pci read size) */
 
 static int force;			/* Don't complain if no devices match */
 static int verbose;			/* Verbosity level */
@@ -41,7 +43,8 @@ struct op {
   unsigned int hdr_type_mask;
   unsigned int addr;
   unsigned int width;			/* Byte width of the access */
-  unsigned int span;            /* Width of variable-sized window in bytes (0 unless .V) */
+  int32_t span;                 /* Width of variable-sized window in bytes (0 unless .V) */
+  unsigned int auto_discov;     /* Dynamically determine the span at runtime? */
   unsigned int num_values;		/* Number of values to write; 0=read */
   unsigned int number;                 /* The n-th capability of that id */
   struct value values[0];
@@ -111,15 +114,38 @@ trace(const char *fmt, ...)
   va_end(args);
 }
 
+static u32
+auto_discov_len(struct pci_dev *dev, int addr, int shift)
+{
+  u32 header = pci_read_long(dev, addr);
+  return (header >> shift) & 0xfff;
+}
+
+static u32
+det_ext_cap_defined_length(struct pci_dev *dev, int cap_base, int cap_id, int cap_type)
+{
+  if (cap_type != PCI_CAP_EXTENDED)
+    die("Auto length only supports extended vendor-defined capabilities");
+
+  switch (cap_id)
+    {
+      case PCI_EXT_CAP_ID_DVSEC:
+      case PCI_EXT_CAP_ID_VNDR:
+        return auto_discov_len(dev, cap_base + 4, 20);
+      default:
+        die("Auto length not supported for this capability");
+    }
+}
+
 static unsigned int
 pci_read(struct pci_dev *dev, int addr, int w)
 {
   switch (w)
-  {
-    case 1:  return pci_read_byte(dev, addr);
-    case 2:  return pci_read_word(dev, addr);
-    default: return pci_read_long(dev, addr);
-  }
+    {
+      case 1:  return pci_read_byte(dev, addr);
+      case 2:  return pci_read_word(dev, addr);
+      default: return pci_read_long(dev, addr);
+    }
 }
 
 static unsigned int
@@ -137,9 +163,9 @@ static void
 print_le_bytes(u32 x, int width)
 {
   for (int b = 0; b < width; b++)
-  {
-    printf("%02x", (x >> (8 * b)) & 0xff);
-  }
+    {
+      printf("%02x", (x >> (8 * b)) & 0xff);
+    }
 }
 
 static void
@@ -150,7 +176,7 @@ exec_op(struct op *op, struct pci_dev *dev)
   unsigned int i, x, y;
   int addr = 0;
   int width = op->width;
-  int span = op->span;
+  int32_t span;
   char slot[16];
 
   snprintf(slot, sizeof(slot), "%04x:%02x:%02x.%x", dev->domain, dev->bus, dev->dev, dev->func);
@@ -177,13 +203,23 @@ exec_op(struct op *op, struct pci_dev *dev)
   addr += op->addr;
   trace("@%02x", addr);
 
+  if (op->auto_discov && !op->cap_type)
+    die("%s: Auto length requires a capability", slot);
+
+  span = op->auto_discov
+    ? op->span + (int32_t)det_ext_cap_defined_length(dev, addr - op->addr, op->cap_id, op->cap_type)
+    : op->span;
+
+  if (span < 0)
+    die("Span cannot be negative: \"%d\"", span);
+
   /* We have already checked it when parsing, but addressing relative to capabilities can change the address. */
   if (addr & (width-1))
     die("%s: Unaligned access of width %d to register %04x", slot, width, addr);
   if (addr + width > 0x1000)
     die("%s: Access of width %d to register %04x out of range", slot, width, addr);
   if (span && addr + span > 0x1000)
-    die("%s: Access of range %u to register %04x is out of range", slot, span, addr);
+    die("%s: Access of range %d to register %04x is out of range", slot, span, addr);
 
   if (op->hdr_type_mask)
     {
@@ -241,36 +277,25 @@ exec_op(struct op *op, struct pci_dev *dev)
     {
       trace(" = ");
       if (!span)
-      {
-        switch (width)
-	      {
-	        case 1:
-	          x = pci_read_byte(dev, addr);
-	          break;
-	        case 2:
-	          x = pci_read_word(dev, addr);
-	          break;
-	        default:
-	          x = pci_read_long(dev, addr);
-	          break;
+        {
+          x = pci_read(dev, addr, width);
+          printf(formats[width]+1, x);
+          putchar('\n');
         }
-      printf(formats[width]+1, x);
-      putchar('\n');
-      }
       else
-      {
-        int remaining = span;
-        while (remaining)
         {
-          width = determine_width_alignment(addr, remaining);
-          x = pci_read(dev, addr, width);
-          print_le_bytes(x, width);
-          addr += width;
-          remaining -= width;
+          int32_t remaining = span;
+          while (remaining)
+            {
+              width = determine_width_alignment(addr, remaining);
+              x = pci_read(dev, addr, width);
+              print_le_bytes(x, width);
+              addr += width;
+              remaining -= width;
+            }
+
+          putchar('\n');
         }
-
-        putchar('\n');
-      }
     }
 }
 
@@ -494,14 +519,15 @@ GENERIC_HELP
 "Setting commands:\n"
 "<device>:\t-s [[[<domain>]:][<bus>]:][<slot>][.[<func>]]\n"
 "\t\t-d [<vendor>]:[<device>]\n"
-"<reg>:\t\t<base>[+<offset>][.(B|W|L|V[<length>])][@<number>]\n"
+"<reg>:\t\t<base>[+<offset>][.(B|W|L|V[<length>]|V)][@<number>]\n"
 "<base>:\t\t<address>\n"
 "\t\t<named-register>\n"
 "\t\t[E]CAP_<capability-name>\n"
 "\t\t[E]CAP<capability-number>\n"
 "<values>:\t<value>[,<value>...]\n"
 "<value>:\t<hex>\n"
-"<length>:\thex (number of bytes; multiple of split width)\n"
+"<length>:\t<hex> (number of bytes)\n"
+"V:\tdynamic, runtime discovery of header length\n"
 "\t\t<hex>:<mask>\n");
   exit(0);
 }
@@ -726,6 +752,7 @@ static void parse_op(char *c, struct group *group)
   char *span = NULL;
   int n, j;
   unsigned int span_val = 0;
+  unsigned int auto_discov = 0;
   struct op *op;
 
   /* Split the argument */
@@ -736,15 +763,34 @@ static void parse_op(char *c, struct group *group)
     *number++ = 0;
   if (width = strchr(base, '.'))
     *width++ = 0;
-  if (width && (span = strchr(width, '[')))
+  if (width)
     {
-      char *stop;
-      *span++ = 0;
-      if (parse_x32(span, &stop, &span_val) < 0 || !stop || *stop != ']' || stop[1])
-        parse_err("Invalid span \"%s\"", span);
-      if (span_val == 0) {
-        parse_err("Span must be a non-zero value. Span is: \"%d\"", span_val);
-      }
+      if (span = strchr(width, '['))
+        {
+          char *close;
+          *span++ = 0;
+
+          if (strcasecmp(width, "V"))
+            parse_err("Span is only allowed on the variable length operator \".V\"");
+
+          close = strchr(span, ']');
+          if (!close)
+            parse_err("Invalid span provided : \"%s\"", span);
+
+          if (close[1])
+            parse_err("Invalid characters placed after \"]\". Please use \".V\" or \".V[len]\"");
+
+          *close = 0;
+          if (parse_x32(span, NULL, &span_val) != 1)
+            parse_err("Invalid span provided: \"%s\"", span);
+          if (span_val == 0)
+            parse_err("Span must be a non-zero value. Span is: \"%d\"", span_val);
+        }
+      else if(!strcasecmp(width, "V"))
+        {
+          auto_discov = 1;
+          span = "V";
+        }
     }
   if (offset = strchr(base, '+'))
     *offset++ = 0;
@@ -762,9 +808,7 @@ static void parse_op(char *c, struct group *group)
     }
 
   if (span && n)
-  {
-    parse_err("Variable length (.V[N]) operations are a read only feature");
-  }
+    parse_err("Variable length (.V or .V[...]) is a read only feature");
 
   /* Allocate the operation */
   op = xmalloc(sizeof(struct op) + n*sizeof(struct value));
@@ -774,7 +818,7 @@ static void parse_op(char *c, struct group *group)
   op->num_values = n;
 
   /* What is the width suffix? */
-  if (width && !span)
+  if (width && strcasecmp(width, "V"))
     {
       if (width[1])
 	parse_err("Invalid width \"%s\"", width);
@@ -792,11 +836,18 @@ static void parse_op(char *c, struct group *group)
     }
   else if (span)
     {
-     if (!width || (*width & 0xdf) != 'V' || width[1])
-      parse_err("Invalid variable-width suffix; expected .V[N]");
+      if (!width || strncasecmp(width, "V", 1) || width[1])
+        parse_err("Invalid variable-width suffix; expected .V[N]");
 
-    op->width = MAX_SPLIT_WIDTH;
-    op->span = span_val;
+      if (auto_discov)
+        {
+          op->span = 0;
+          op->auto_discov = auto_discov;
+        }
+      else
+        op->span = span_val;
+
+      op->width = MAX_OP_WIDTH;
     }
   else
     op->width = 0;
@@ -825,10 +876,14 @@ static void parse_op(char *c, struct group *group)
       if (parse_x32(offset, NULL, &off) <= 0 || off >= 0x1000)
 	parse_err("Invalid offset \"%s\"", offset);
       op->addr += off;
+
+      /* Adjust for the provided offset in preparation for the auto-discovered, raw span */
+      if (auto_discov)
+        op->span -= off;
     }
 
   /* Check range */
-  unsigned int range_span = op->span ? op->span : op->width * (n ? n : 1);
+  unsigned int range_span = op->span ? (u32)op->span : op->width * (n ? n : 1);
   if (op->addr >= 0x1000 || op->addr + range_span > 0x1000)
     parse_err("Register number %02x out of range", op->addr);
   if (op->addr & (op->width - 1))
diff --git a/setpci.man b/setpci.man
index 40267de..f39b87e 100644
--- a/setpci.man
+++ b/setpci.man
@@ -157,15 +157,23 @@ To choose how many bytes (1, 2, or 4) should be transferred, you should append a
 specifier \fB.B\fP, \fB.W\fP, or \fB.L\fP. The width can be omitted if you are
 referring to a register by its name and the width of the register is well known.
 .IP \(bu
-To transfer a variable-length window larger than a single access, apend \fB.V[len]\fP,
+To operate on a variable-length window larger than a single access, append \fB.V[len]\fP,
 where \fBlen\fP is a hexademical byte count set statically within setpci (4). The window is read
-as a sequence of aligned longword accesses, low address first. Each chunk is assembled in
+as a sequence of aligned long accesses, low address first. Each chunk is assembled in
 little-endian, but the final result is in big-endian. This is the opposite of other operations.
-If there is a misalignment, that is fixed in the, first couple reads: we will do a two byte and
+If there is a misalignment, that is fixed in the first couple reads: we will do a two byte and
 a one byte read or one or the other to reach four-byte alignment, and then continue to read four
-bytes. Because PCI configuraiton space has no atomic access wider than a longword, a
+bytes. Because PCI configuration space has no atomic access wider than a long, a
 \fB.V[len]\fP operation is \fInot\fP atomic: if the underlying field changes between the
 individual accesses, the value may be read torn.
+.IP \(bu
+To use a variable-length window larger than a single access specifically for reads on vendor-defined
+registers / values, you can use .V. In this mode, setpci will, at runtime, dynamically
+determine the length defined within the vendor header. Note that this only works for
+vendor-defined registers like ECAP_DVSEC or ECAP_VNDR. Note that the way in which reading is done and
+the output is produced is the same as the non-automatic variable-length window. That means the
+result is returned in big-endian, which is the \fIopposite\fP of all other operation sizes.
+
 .IP \(bu
 Finally, if a capability exists multiple times you can choose which one to target using
 \fB@number\fP. Indexing starts at 0.
@@ -192,6 +200,15 @@ asks for the first 32-bit word of the extended capability with ID 0x108.
 .IP ECAP_DSN+4.V[8]
 reads the 8-byte Device Serial Number as a single little-endian value,
 equivalent to reading the longwords at \fB+4\fP and \fB+8\fP and combining them.
+reads starting from the offset provided.
+.IP ECAP_DVSEC.V
+resolves the DVSEC capability on the device, reads DVSEC header 1 at base+4,
+extracts the length and reads as many bytes.
+.IP ECAP_VNDR+4.V
+resolves the Vendor specific capbaility on the device, reads the VSEC header,
+extracst the length and reads as many bytes within the span found.
+reads from the provided offset, automatically adjusting the total span to read with respect
+to the adjusted starting position
 
 .SH SEE ALSO
 .BR lspci (8),
-- 
2.43.0

