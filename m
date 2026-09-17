Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96843A873D
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666563; cv=none; b=uJmGIXn8iW3k7I6ktEHW0t3ZZG3gp6XeMcFwfMnrbwahbkfuNgT9jxcEONEYR8+YzsAR2z79QEk26TIjHz5S2KMS7u6QMTc5fZ0lKq6p2JkFH54S2QPT6rXO1EG5U/0WZ89NW9Gu2kD8yu37n5LmARxTV6i084BK0iYmTEoUJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666563; c=relaxed/simple;
	bh=/KMpKLFy5CDkwbY5Nw7OjCeNngteNncdxZqnKkSdxCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mL5WjowMKe7Jpy7diS0h+dPXyODaJWsbfDID2ZMh6XgJto67Dq2PKdfsEHXjdw2K2hg0QyBYQWUH+Hgl67R5T1hdZ8bnxdh64MarRZqb7VbWI2vn3O5XorgxtrA1JUPSW7VIPw+Ahud4cRuJIPjNLTKgMapAKd9r88Rg5IgeHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=JJWcbjGq; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="JJWcbjGq"
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 68HFaKgG1519943;
	Thu, 17 Sep 2026 17:17:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=apr2026.eng;
	 bh=qg1v7+qN0bwT8gHfaUG8FUzBN9E+Qh5JXNdIbLg0xfc=; b=JJWcbjGqi2BZ
	XuoIJKjtAFJcULhKAl9utDpLdtgCGpLY31/iKEjiFls9JxWbrgkFEtgACZ9owwEr
	k/3gl6xNz0wT4+LlUUw22U+UkgbCZl3GzqbCYOAgcxpOVRiKPJVihHixfSQo0+db
	9Uq+/9DcQLHJPr1AZT4G1C1PXk5gM+drC5wnDU5c9/8IJrnRheV1RZJ48nq+Zuxm
	LlRWKC+n2pP2Losa6fkQ03+NclWMr5uiRclz+LJk9ja5V7AcSpOCD9DZ7wpmTsKt
	6PGWn+hXebP3G0SQ28vZkdaG45KHm+hD0hM4qG/QIXmoEuRfu1dMp7luruhW/+xb
	TJ0/Qnzw2A==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4grb1anacn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:17:03 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 68HG6B84029295;
	Thu, 17 Sep 2026 09:17:03 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4gn4q7urp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 09:17:02 -0700 (PDT)
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 17 Sep 2026 09:17:02 -0700
Received: from bos-lpnz1z1y (172.27.118.139) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.43 via Frontend Transport; Thu, 17 Sep 2026 09:17:02 -0700
Received: by bos-lpnz1z1y (Postfix, from userid 56609)
	id 33BF8241CAB; Thu, 17 Sep 2026 12:17:02 -0400 (EDT)
From: jlefkowi <jlefkowi@akamai.com>
To: <linux-pci@vger.kernel.org>
CC: <mj@ucw.cz>, <bchaney@akamai.com>, <mpelland@akamai.com>,
        jlefkowi
	<jlefkowi@akamai.com>
Subject: [PATCH 1/3] feature: add .V[N] variable-length access specifier such that reads are allowed within a window of 'N' bytes (inputted as hex)
Date: Thu, 17 Sep 2026 12:16:29 -0400
Message-ID: <20260917161631.801636-2-jlefkowi@akamai.com>
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
X-Proofpoint-GUID: HZ0P_F4apba79oErMrI6TzwWcZHUSJzd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfXxne2f8cxl4ny
 1tt0n+3cU6dnPCq8MYnFQMx3G2LcvYtvgt44zvHPBtjc85Px0nC79zlqdGUGgvCH4Qn/+OqjaTC
 Zg5o6Vti5E0vi1u/XohAqQBfN1WEDUg=
X-Proofpoint-ORIG-GUID: HZ0P_F4apba79oErMrI6TzwWcZHUSJzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfX/xtkDRiHvgcD
 61ognzC23tJ8MZ3NEIKc5yyWRmnPYNk1joBtSqQz6abwIiklQU8BKrsPNQyxhujaDZrZlKnL+B4
 0iWGdWQyuVgf6DDsgGe58kvqcoWCQ541Bb38Ap3vNxe9T6ewDRv7h0gi77UkzeZSTN6Lw77oJCT
 2QCr8zYD2xfWkFmlrx4C7iP4pLV1JKCg+GpV+JIUayk+3TuGYD2ReUhR61VO7WZuJfyTtD59RVd
 mYbccVWZNWb7O4tdKZCIEi1XPy+jkqi3QckRmXU17rEYtz2dMiHk7vPKcP7xx+YjR50vhLQ5tdC
 7l8gkCRZuEdxwsdLN311azwvFrfsC3AzNvME/wFT6xhIm3XK6zocrS6y7qOmuwSF8wDDOSPRhV0
 OFjcAhEI2TrvftMo77gqOF0HkOU+krEZvrTkryqvodZMtVu7RBholR9Hsm+syPndNszD/6vcdmw
 S/hHPIU6g2fsXse8/0A==
X-Authority-Analysis: v=2.4 cv=N6u8hG9B c=1 sm=1 tr=0 ts=6aac127f cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=X7Ea-ya5AAAA:8 a=NNo_rWC6itzKJ7vnSYcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170231

This acts as a single operation, instead of manual per-dword reads.
Assembly of the read's result is automatic into an unbounded-size value, returned in big-edian order.

Since config space has no atomic access wider than a longword, this is also a non-atomic action and
should therefore be treated with care.

Signed-off-by: Jacob Lefkowitz jlefkowi@akamai.com
---
 setpci.c   | 113 +++++++++++++++++++++++++++++++++++++++++++++--------
 setpci.man |  13 ++++++
 2 files changed, 110 insertions(+), 16 deletions(-)

diff --git a/setpci.c b/setpci.c
index e7f18ee..1b3476d 100644
--- a/setpci.c
+++ b/setpci.c
@@ -17,6 +17,8 @@
 #define PCIUTILS_SETPCI
 #include "pciutils.h"
 
+#define MAX_SPLIT_WIDTH 4 /* Has to be 1, 2, or 4 (valid singular pci read or write size) */
+
 static int force;			/* Don't complain if no devices match */
 static int verbose;			/* Verbosity level */
 static int demo_mode;			/* Only show */
@@ -39,6 +41,7 @@ struct op {
   unsigned int hdr_type_mask;
   unsigned int addr;
   unsigned int width;			/* Byte width of the access */
+  unsigned int span;            /* Width of variable-sized window in bytes (0 unless .V) */
   unsigned int num_values;		/* Number of values to write; 0=read */
   unsigned int number;                 /* The n-th capability of that id */
   struct value values[0];
@@ -108,6 +111,37 @@ trace(const char *fmt, ...)
   va_end(args);
 }
 
+static unsigned int
+pci_read(struct pci_dev *dev, int addr, int w)
+{
+  switch (w)
+  {
+    case 1:  return pci_read_byte(dev, addr);
+    case 2:  return pci_read_word(dev, addr);
+    default: return pci_read_long(dev, addr);
+  }
+}
+
+static unsigned int
+determine_width_alignment(unsigned int addr, int remaining)
+{
+  if ((addr & 3) == 0 && remaining >= 4)
+    return 4;
+  if ((addr & 1) == 0 && remaining >= 2)
+    return 2;
+
+  return 1;
+}
+
+static void
+print_le_bytes(u32 x, int width)
+{
+  for (int b = 0; b < width; b++)
+  {
+    printf("%02x", (x >> (8 * b)) & 0xff);
+  }
+}
+
 static void
 exec_op(struct op *op, struct pci_dev *dev)
 {
@@ -116,6 +150,7 @@ exec_op(struct op *op, struct pci_dev *dev)
   unsigned int i, x, y;
   int addr = 0;
   int width = op->width;
+  int span = op->span;
   char slot[16];
 
   snprintf(slot, sizeof(slot), "%04x:%02x:%02x.%x", dev->domain, dev->bus, dev->dev, dev->func);
@@ -147,6 +182,8 @@ exec_op(struct op *op, struct pci_dev *dev)
     die("%s: Unaligned access of width %d to register %04x", slot, width, addr);
   if (addr + width > 0x1000)
     die("%s: Access of width %d to register %04x out of range", slot, width, addr);
+  if (span && addr + span > 0x1000)
+    die("%s: Access of range %u to register %04x is out of range", slot, span, addr);
 
   if (op->hdr_type_mask)
     {
@@ -203,20 +240,37 @@ exec_op(struct op *op, struct pci_dev *dev)
   else
     {
       trace(" = ");
-      switch (width)
-	{
-	case 1:
-	  x = pci_read_byte(dev, addr);
-	  break;
-	case 2:
-	  x = pci_read_word(dev, addr);
-	  break;
-	default:
-	  x = pci_read_long(dev, addr);
-	  break;
-	}
+      if (!span)
+      {
+        switch (width)
+	      {
+	        case 1:
+	          x = pci_read_byte(dev, addr);
+	          break;
+	        case 2:
+	          x = pci_read_word(dev, addr);
+	          break;
+	        default:
+	          x = pci_read_long(dev, addr);
+	          break;
+        }
       printf(formats[width]+1, x);
       putchar('\n');
+      }
+      else
+      {
+        int remaining = span;
+        while (remaining)
+        {
+          width = determine_width_alignment(addr, remaining);
+          x = pci_read(dev, addr, width);
+          print_le_bytes(x, width);
+          addr += width;
+          remaining -= width;
+        }
+
+        putchar('\n');
+      }
     }
 }
 
@@ -440,13 +494,14 @@ GENERIC_HELP
 "Setting commands:\n"
 "<device>:\t-s [[[<domain>]:][<bus>]:][<slot>][.[<func>]]\n"
 "\t\t-d [<vendor>]:[<device>]\n"
-"<reg>:\t\t<base>[+<offset>][.(B|W|L)][@<number>]\n"
+"<reg>:\t\t<base>[+<offset>][.(B|W|L|V[<length>])][@<number>]\n"
 "<base>:\t\t<address>\n"
 "\t\t<named-register>\n"
 "\t\t[E]CAP_<capability-name>\n"
 "\t\t[E]CAP<capability-number>\n"
 "<values>:\t<value>[,<value>...]\n"
 "<value>:\t<hex>\n"
+"<length>:\thex (number of bytes; multiple of split width)\n"
 "\t\t<hex>:<mask>\n");
   exit(0);
 }
@@ -668,7 +723,9 @@ static void parse_op(char *c, struct group *group)
 {
   char *base, *offset, *width, *value, *number;
   char *e, *f;
+  char *span = NULL;
   int n, j;
+  unsigned int span_val = 0;
   struct op *op;
 
   /* Split the argument */
@@ -679,6 +736,16 @@ static void parse_op(char *c, struct group *group)
     *number++ = 0;
   if (width = strchr(base, '.'))
     *width++ = 0;
+  if (width && (span = strchr(width, '[')))
+    {
+      char *stop;
+      *span++ = 0;
+      if (parse_x32(span, &stop, &span_val) < 0 || !stop || *stop != ']' || stop[1])
+        parse_err("Invalid span \"%s\"", span);
+      if (span_val == 0) {
+        parse_err("Span must be a non-zero value. Span is: \"%d\"", span_val);
+      }
+    }
   if (offset = strchr(base, '+'))
     *offset++ = 0;
 
@@ -694,6 +761,11 @@ static void parse_op(char *c, struct group *group)
 	  n++;
     }
 
+  if (span && n)
+  {
+    parse_err("Variable length (.V[N]) operations are a read only feature");
+  }
+
   /* Allocate the operation */
   op = xmalloc(sizeof(struct op) + n*sizeof(struct value));
   memset(op, 0, sizeof(struct op));
@@ -702,7 +774,7 @@ static void parse_op(char *c, struct group *group)
   op->num_values = n;
 
   /* What is the width suffix? */
-  if (width)
+  if (width && !span)
     {
       if (width[1])
 	parse_err("Invalid width \"%s\"", width);
@@ -716,7 +788,15 @@ static void parse_op(char *c, struct group *group)
 	  op->width = 4; break;
 	default:
 	  parse_err("Invalid width \"%c\"", *width);
-	}
+	  }
+    }
+  else if (span)
+    {
+     if (!width || (*width & 0xdf) != 'V' || width[1])
+      parse_err("Invalid variable-width suffix; expected .V[N]");
+
+    op->width = MAX_SPLIT_WIDTH;
+    op->span = span_val;
     }
   else
     op->width = 0;
@@ -748,7 +828,8 @@ static void parse_op(char *c, struct group *group)
     }
 
   /* Check range */
-  if (op->addr >= 0x1000 || op->addr + op->width*(n ? n : 1) > 0x1000)
+  unsigned int range_span = op->span ? op->span : op->width * (n ? n : 1);
+  if (op->addr >= 0x1000 || op->addr + range_span > 0x1000)
     parse_err("Register number %02x out of range", op->addr);
   if (op->addr & (op->width - 1))
     parse_err("Unaligned register address %02x", op->addr);
diff --git a/setpci.man b/setpci.man
index 5d70d96..40267de 100644
--- a/setpci.man
+++ b/setpci.man
@@ -157,6 +157,16 @@ To choose how many bytes (1, 2, or 4) should be transferred, you should append a
 specifier \fB.B\fP, \fB.W\fP, or \fB.L\fP. The width can be omitted if you are
 referring to a register by its name and the width of the register is well known.
 .IP \(bu
+To transfer a variable-length window larger than a single access, apend \fB.V[len]\fP,
+where \fBlen\fP is a hexademical byte count set statically within setpci (4). The window is read
+as a sequence of aligned longword accesses, low address first. Each chunk is assembled in
+little-endian, but the final result is in big-endian. This is the opposite of other operations.
+If there is a misalignment, that is fixed in the, first couple reads: we will do a two byte and
+a one byte read or one or the other to reach four-byte alignment, and then continue to read four
+bytes. Because PCI configuraiton space has no atomic access wider than a longword, a
+\fB.V[len]\fP operation is \fInot\fP atomic: if the underlying field changes between the
+individual accesses, the value may be read torn.
+.IP \(bu
 Finally, if a capability exists multiple times you can choose which one to target using
 \fB@number\fP. Indexing starts at 0.
 
@@ -179,6 +189,9 @@ specifies the upper byte of the vendor ID register (remember, PCI is little-endi
 corresponds to the second word of the power management capability.
 .IP ECAP108.l
 asks for the first 32-bit word of the extended capability with ID 0x108.
+.IP ECAP_DSN+4.V[8]
+reads the 8-byte Device Serial Number as a single little-endian value,
+equivalent to reading the longwords at \fB+4\fP and \fB+8\fP and combining them.
 
 .SH SEE ALSO
 .BR lspci (8),
-- 
2.43.0

