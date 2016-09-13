Return-Path: <leedom@chelsio.com>
Return-Path: <leedom@chelsio.com>
From: Casey Leedom <leedom@chelsio.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Hariprasad S <hariprasad@chelsio.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, SWise OGC <swise@opengridcomputing.com>, "Hannes
 Reinecke" <hare@suse.de>
Subject: Re: [PATCH] pci: Use same logic in pci_vpd_read as that of
 pci_vpd_write
Date: Tue, 13 Sep 2016 22:16:25 +0000
Message-ID: <DM5PR12MB1786F02F0A07E6F5EC7CD7D5C8FE0@DM5PR12MB1786.namprd12.prod.outlook.com>
References: <1466827722-17287-1-git-send-email-hariprasad@chelsio.com>
 <20160808210858.GC6129@localhost>
 <DM5PR12MB17864DB8AA81CBA21EBB7AA8C81B0@DM5PR12MB1786.namprd12.prod.outlook.com>,<20160818205524.GO27353@localhost>
In-Reply-To: <20160818205524.GO27353@localhost>
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1786F02F0A07E6F5EC7CD7D5C8FE0DM5PR12MB1786namp_"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--_000_DM5PR12MB1786F02F0A07E6F5EC7CD7D5C8FE0DM5PR12MB1786namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

  And now sorry for my long-delayed response =97 I was one vacation in Euro=
pe for four weeks hut hiking around the Monte Rosa Mastiff, etc.  Loads of =
fun and exhausting.


  I see your point regarding the sysfs interface.  So I think that we shoul=
d make sure that all callers correctly handle short reads.  I don't think t=
here are that many, so it should be an easy task.


Casey

________________________________
From: Bjorn Helgaas <helgaas@kernel.org>
Sent: Thursday, August 18, 2016 1:55:25 PM
To: Casey Leedom
Cc: Hariprasad S; bhelgaas@google.com; linux-pci@vger.kernel.org; SWise OGC=
; Hannes Reinecke
Subject: Re: [PATCH] pci: Use same logic in pci_vpd_read as that of pci_vpd=
_write

Hi Casey,

Sorry for the delay in responding.

On Mon, Aug 08, 2016 at 09:20:22PM +0000, Casey Leedom wrote:
> | From: Bjorn Helgaas <helgaas@kernel.org>
> | Sent: Monday, August 8, 2016 2:08 PM
> |
> | I think the existing semantics are the same as for the read(2)
> | syscall: we return the number of bytes read, which may be less than
> | the size requested, and callers may use random garbage if they don't
> | check for short reads.
>
> read(2) is a generic I/O system call, which maintains a read pointer with
> lseek(2) semantics, etc.  This seems like an Apples and Oranges
> comparison.
>
> | If we make pci_read_vpd() return error instead of a short read, how do
> | callers figure out how much to request?
>
> The same question could be asked of the pci_write_vpd() call which
> currently throws an error is any portion of the requested write is beyond
> the recorded VPD area.  Also, isn't this what (struct pci_dev *)->vpd.len
> is for?  Although I think we'd want an API to retrieve that rather than h=
ave
> callers simply access the potentially uninitialized field which is lazily
> initialized.  On the other hand, we don't seem to have any current caller=
s
> with this issue.

Drivers that read VPD probably can figure out how much to read.  The
place I'm worried about is read_vpd_attr(), the hook for reading VPD
via sysfs.  If we do something like "cat /sys/.../vpd", I think cat
will try to read a large chunk and it will currently get a short read.
If we return an error instead of the short read, I think the sysfs
file will be much harder to use.

Bjorn

--_000_DM5PR12MB1786F02F0A07E6F5EC7CD7D5C8FE0DM5PR12MB1786namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; =
background-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>&nbsp; And now sorry for my long-delayed response =97 I was one vacation=
 in Europe for four weeks hut hiking around the Monte Rosa Mastiff, etc.&nb=
sp; Loads of fun and exhausting.</p>
<p><br>
</p>
<p>&nbsp; I see your point regarding the sysfs interface.&nbsp; So I think =
that we should make sure that all callers correctly handle short reads.&nbs=
p; I don't think there are that many, so it should be an easy task.</p>
<p><br>
</p>
<p>Casey<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Bjorn Helgaas &lt;h=
elgaas@kernel.org&gt;<br>
<b>Sent:</b> Thursday, August 18, 2016 1:55:25 PM<br>
<b>To:</b> Casey Leedom<br>
<b>Cc:</b> Hariprasad S; bhelgaas@google.com; linux-pci@vger.kernel.org; SW=
ise OGC; Hannes Reinecke<br>
<b>Subject:</b> Re: [PATCH] pci: Use same logic in pci_vpd_read as that of =
pci_vpd_write</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Casey,<br>
<br>
Sorry for the delay in responding.<br>
<br>
On Mon, Aug 08, 2016 at 09:20:22PM &#43;0000, Casey Leedom wrote:<br>
&gt; | From: Bjorn Helgaas &lt;helgaas@kernel.org&gt;<br>
&gt; | Sent: Monday, August 8, 2016 2:08 PM<br>
&gt; | <br>
&gt; | I think the existing semantics are the same as for the read(2)<br>
&gt; | syscall: we return the number of bytes read, which may be less than<=
br>
&gt; | the size requested, and callers may use random garbage if they don't=
<br>
&gt; | check for short reads.<br>
&gt; <br>
&gt; read(2) is a generic I/O system call, which maintains a read pointer w=
ith<br>
&gt; lseek(2) semantics, etc.&nbsp; This seems like an Apples and Oranges<b=
r>
&gt; comparison.<br>
&gt; <br>
&gt; | If we make pci_read_vpd() return error instead of a short read, how =
do<br>
&gt; | callers figure out how much to request?<br>
&gt; <br>
&gt; The same question could be asked of the pci_write_vpd() call which<br>
&gt; currently throws an error is any portion of the requested write is bey=
ond<br>
&gt; the recorded VPD area.&nbsp; Also, isn't this what (struct pci_dev *)-=
&gt;vpd.len<br>
&gt; is for?&nbsp; Although I think we'd want an API to retrieve that rathe=
r than have<br>
&gt; callers simply access the potentially uninitialized field which is laz=
ily<br>
&gt; initialized.&nbsp; On the other hand, we don't seem to have any curren=
t callers<br>
&gt; with this issue.<br>
<br>
Drivers that read VPD probably can figure out how much to read.&nbsp; The<b=
r>
place I'm worried about is read_vpd_attr(), the hook for reading VPD<br>
via sysfs.&nbsp; If we do something like &quot;cat /sys/.../vpd&quot;, I th=
ink cat<br>
will try to read a large chunk and it will currently get a short read.<br>
If we return an error instead of the short read, I think the sysfs<br>
file will be much harder to use.<br>
<br>
Bjorn<br>
</div>
</span></font>
</body>
</html>

--_000_DM5PR12MB1786F02F0A07E6F5EC7CD7D5C8FE0DM5PR12MB1786namp_--
