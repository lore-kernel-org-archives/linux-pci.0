Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:52701
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759248AbdENPi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 May 2017 11:38:59 -0400
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Sanjeev <ghane0@gmail.com>,
        Michael Heimpold <michael.heimpold@i2se.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Richard Sailer <richard@weltraumpflege.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/13] docs: update old references for DocBook from the documentation
Date: Sun, 14 May 2017 12:38:37 -0300
Message-Id: <af38a0a99bf7207924f42b1dc70f96c2cce229d2.1494775891.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494775891.git.mchehab@s-opensource.com>
References: <cover.1494775891.git.mchehab@s-opensource.com>
MIME-Version: 1.0
In-Reply-To: <cover.1494775891.git.mchehab@s-opensource.com>
References: <cover.1494775891.git.mchehab@s-opensource.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DocBook is mentioned several times at the documentation. Update
the obsolete references from it at the DocBook.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/PCI/MSI-HOWTO.txt            |  2 +-
 Documentation/admin-guide/README.rst       |  6 ---
 Documentation/doc-guide/index.rst          |  1 -
 Documentation/doc-guide/sphinx.rst         |  5 ---
 Documentation/fb/api.txt                   |  4 +-
 Documentation/gpu/todo.rst                 |  2 +-
 Documentation/kernel-doc-nano-HOWTO.txt    | 65 +++++-------------------------
 Documentation/process/changes.rst          | 26 +++---------
 Documentation/process/howto.rst            |  8 ----
 Documentation/process/kernel-docs.rst      | 34 +---------------
 Documentation/translations/ja_JP/howto.rst |  7 ----
 Documentation/translations/ko_KR/howto.rst |  7 ----
 12 files changed, 21 insertions(+), 146 deletions(-)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 1e37138027a3..618e13d5e276 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -186,7 +186,7 @@ must disable interrupts while the lock is held.  If the device sends
 a different interrupt, the driver will deadlock trying to recursively
 acquire the spinlock.  Such deadlocks can be avoided by using
 spin_lock_irqsave() or spin_lock_irq() which disable local interrupts
-and acquire the lock (see Documentation/DocBook/kernel-locking).
+and acquire the lock (see Documentation/kernel-hacking/locking.rst).
 
 4.5 How to tell whether MSI/MSI-X is enabled on a device
 
diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index b96e80f79e85..b5343c5aa224 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -55,12 +55,6 @@ Documentation
    contains information about the problems, which may result by upgrading
    your kernel.
 
- - The Documentation/DocBook/ subdirectory contains several guides for
-   kernel developers and users.  These guides can be rendered in a
-   number of formats:  PostScript (.ps), PDF, HTML, & man-pages, among others.
-   After installation, ``make psdocs``, ``make pdfdocs``, ``make htmldocs``,
-   or ``make mandocs`` will render the documentation in the requested format.
-
 Installing the kernel source
 ----------------------------
 
diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
index 6fff4024606e..a7f95d7d3a63 100644
--- a/Documentation/doc-guide/index.rst
+++ b/Documentation/doc-guide/index.rst
@@ -10,7 +10,6 @@ How to write kernel documentation
    sphinx.rst
    kernel-doc.rst
    parse-headers.rst
-   docbook.rst
 
 .. only::  subproject and html
 
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 731334de3efd..84e8e8a9cbdb 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -15,11 +15,6 @@ are used to describe the functions and types and design of the code. The
 kernel-doc comments have some special structure and formatting, but beyond that
 they are also treated as reStructuredText.
 
-There is also the deprecated DocBook toolchain to generate documentation from
-DocBook XML template files under ``Documentation/DocBook``. The DocBook files
-are to be converted to reStructuredText, and the toolchain is slated to be
-removed.
-
 Finally, there are thousands of plain text documentation files scattered around
 ``Documentation``. Some of these will likely be converted to reStructuredText
 over time, but the bulk of them will remain in plain text.
diff --git a/Documentation/fb/api.txt b/Documentation/fb/api.txt
index d4ff7de85700..d52cf1e3b975 100644
--- a/Documentation/fb/api.txt
+++ b/Documentation/fb/api.txt
@@ -289,12 +289,12 @@ the FB_CAP_FOURCC bit in the fb_fix_screeninfo capabilities field.
 FOURCC definitions are located in the linux/videodev2.h header. However, and
 despite starting with the V4L2_PIX_FMT_prefix, they are not restricted to V4L2
 and don't require usage of the V4L2 subsystem. FOURCC documentation is
-available in Documentation/DocBook/v4l/pixfmt.xml.
+available in Documentation/media/uapi/v4l/pixfmt.rst.
 
 To select a format, applications set the grayscale field to the desired FOURCC.
 For YUV formats, they should also select the appropriate colorspace by setting
 the colorspace field to one of the colorspaces listed in linux/videodev2.h and
-documented in Documentation/DocBook/v4l/colorspaces.xml.
+documented in Documentation/media/uapi/v4l/colorspaces.rst.
 
 The red, green, blue and transp fields are not used with the FOURCC-based API.
 For forward compatibility reasons applications must zero those fields, and
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 1bdb7356a310..6162d0e9dc28 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -228,7 +228,7 @@ The DRM reference documentation is still lacking kerneldoc in a few areas. The
 task would be to clean up interfaces like moving functions around between
 files to better group them and improving the interfaces like dropping return
 values for functions that never fail. Then write kerneldoc for all exported
-functions and an overview section and integrate it all into the drm DocBook.
+functions and an overview section and integrate it all into the drm book.
 
 See https://dri.freedesktop.org/docs/drm/ for what's there already.
 
diff --git a/Documentation/kernel-doc-nano-HOWTO.txt b/Documentation/kernel-doc-nano-HOWTO.txt
index 104740ea0041..c23e2c5ab80d 100644
--- a/Documentation/kernel-doc-nano-HOWTO.txt
+++ b/Documentation/kernel-doc-nano-HOWTO.txt
@@ -17,8 +17,8 @@ The format for this documentation is called the kernel-doc format.
 It is documented in this Documentation/kernel-doc-nano-HOWTO.txt file.
 
 This style embeds the documentation within the source files, using
-a few simple conventions.  The scripts/kernel-doc perl script, some
-SGML templates in Documentation/DocBook, and other tools understand
+a few simple conventions.  The scripts/kernel-doc perl script, the
+Documentation/sphinx/kerneldoc.py Sphinx extension and other tools understand
 these conventions, and are used to extract this embedded documentation
 into various documents.
 
@@ -122,15 +122,9 @@ are:
 - scripts/kernel-doc
 
   This is a perl script that hunts for the block comments and can mark
-  them up directly into DocBook, man, text, and HTML. (No, not
+  them up directly into DocBook, ReST, man, text, and HTML. (No, not
   texinfo.)
 
-- Documentation/DocBook/*.tmpl
-
-  These are SGML template files, which are normal SGML files with
-  special place-holders for where the extracted documentation should
-  go.
-
 - scripts/docproc.c
 
   This is a program for converting SGML template files into SGML
@@ -145,25 +139,18 @@ are:
 
 - Makefile
 
-  The targets 'xmldocs', 'psdocs', 'pdfdocs', and 'htmldocs' are used
-  to build XML DocBook files, PostScript files, PDF files, and html files
-  in Documentation/DocBook. The older target 'sgmldocs' is equivalent
-  to 'xmldocs'.
-
-- Documentation/DocBook/Makefile
-
-  This is where C files are associated with SGML templates.
-
+  The targets 'xmldocs', 'latexdocs', 'pdfdocs', 'epubdocs'and 'htmldocs'
+  are used to build XML DocBook files, LaTeX files, PDF files,
+  ePub files and html files in Documentation/.
 
 How to extract the documentation
 --------------------------------
 
 If you just want to read the ready-made books on the various
-subsystems (see Documentation/DocBook/*.tmpl), just type 'make
-psdocs', or 'make pdfdocs', or 'make htmldocs', depending on your
-preference.  If you would rather read a different format, you can type
-'make xmldocs' and then use DocBook tools to convert
-Documentation/DocBook/*.xml to a format of your choice (for example,
+subsystems, just type 'make epubdocs', or 'make pdfdocs', or 'make htmldocs',
+depending on your preference.  If you would rather read a different format,
+you can type 'make xmldocs' and then use DocBook tools to convert
+Documentation/output/*.xml to a format of your choice (for example,
 'db2html ...' if 'make htmldocs' was not defined).
 
 If you want to see man pages instead, you can do this:
@@ -329,37 +316,7 @@ This is done by using a DOC: section keyword with a section title.  E.g.:
  * hardware, software, or its subject(s).
  */
 
-DOC: sections are used in SGML templates files as indicated below.
-
-
-How to make new SGML template files
------------------------------------
-
-SGML template files (*.tmpl) are like normal SGML files, except that
-they can contain escape sequences where extracted documentation should
-be inserted.
-
-!E<filename> is replaced by the documentation, in <filename>, for
-functions that are exported using EXPORT_SYMBOL: the function list is
-collected from files listed in Documentation/DocBook/Makefile.
-
-!I<filename> is replaced by the documentation for functions that are
-_not_ exported using EXPORT_SYMBOL.
-
-!D<filename> is used to name additional files to search for functions
-exported using EXPORT_SYMBOL.
-
-!F<filename> <function [functions...]> is replaced by the
-documentation, in <filename>, for the functions listed.
-
-!P<filename> <section title> is replaced by the contents of the DOC:
-section titled <section title> from <filename>.
-Spaces are allowed in <section title>; do not quote the <section title>.
-
-!C<filename> is replaced by nothing, but makes the tools check that
-all DOC: sections and documented functions, symbols, etc. are used.
-This makes sense to use when you use !F/!P only and want to verify
-that all documentation is included.
+DOC: sections are used in ReST files.
 
 Tim.
 */ <twaugh@redhat.com>
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index e25d63f8c0da..3aed751e0cb5 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -116,12 +116,11 @@ DevFS has been obsoleted in favour of udev
 
 Linux documentation for functions is transitioning to inline
 documentation via specially-formatted comments near their
-definitions in the source.  These comments can be combined with the
-SGML templates in the Documentation/DocBook directory to make DocBook
-files, which can then be converted by DocBook stylesheets to PostScript,
-HTML, PDF files, and several other formats.  In order to convert from
-DocBook format to a format of your choice, you'll need to install Jade as
-well as the desired DocBook stylesheets.
+definitions in the source.  These comments can be combined with ReST
+files the Documentation/ directory to make enriched documentation, which can
+then be converted to PostScript, HTML, LaTex, ePUB and PDF files.
+In order to convert from ReST format to a format of your choice, you'll need
+Sphinx.
 
 Util-linux
 ----------
@@ -323,12 +322,6 @@ PDF outputs, it is recommended to use version 1.4.6.
   functionalities required for ``XeLaTex`` to work. For PDF output you'll also
   need ``convert(1)`` from ImageMagick (https://www.imagemagick.org).
 
-Other tools
------------
-
-In order to produce documentation from DocBook, you'll also need ``xmlto``.
-Please notice, however, that we're currently migrating all documents to use
-``Sphinx``.
 
 Getting updated software
 ========================
@@ -409,15 +402,6 @@ Quota-tools
 
 - <http://sourceforge.net/projects/linuxquota/>
 
-DocBook Stylesheets
--------------------
-
-- <http://sourceforge.net/projects/docbook/files/docbook-dsssl/>
-
-XMLTO XSLT Frontend
--------------------
-
-- <http://cyberelk.net/tim/xmlto/>
 
 Intel P6 microcode
 ------------------
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 1260f60d4cb9..c6875b1db56f 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -180,14 +180,6 @@ They can also be generated on LaTeX and ePub formats with::
 	make latexdocs
 	make epubdocs
 
-Currently, there are some documents written on DocBook that are in
-the process of conversion to ReST. Such documents will be created in the
-Documentation/DocBook/ directory and can be generated also as
-Postscript or man pages by running::
-
-	make psdocs
-	make mandocs
-
 Becoming A Kernel Developer
 ---------------------------
 
diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 05a7857a4a83..b8cac85a4001 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -40,50 +40,18 @@ Enjoy!
 Docs at the Linux Kernel tree
 -----------------------------
 
-The DocBook books should be built with ``make {htmldocs | psdocs | pdfdocs}``.
 The Sphinx books should be built with ``make {htmldocs | pdfdocs | epubdocs}``.
 
     * Name: **linux/Documentation**
 
       :Author: Many.
       :Location: Documentation/
-      :Keywords: text files, Sphinx, DocBook.
+      :Keywords: text files, Sphinx.
       :Description: Documentation that comes with the kernel sources,
         inside the Documentation directory. Some pages from this document
         (including this document itself) have been moved there, and might
         be more up to date than the web version.
 
-    * Title: **The Kernel Hacking HOWTO**
-
-      :Author: Various Talented People, and Rusty.
-      :Location: Documentation/DocBook/kernel-hacking.tmpl
-      :Keywords: HOWTO, kernel contexts, deadlock, locking, modules,
-        symbols, return conventions.
-      :Description: From the Introduction: "Please understand that I
-        never wanted to write this document, being grossly underqualified,
-        but I always wanted to read it, and this was the only way. I
-        simply explain some best practices, and give reading entry-points
-        into the kernel sources. I avoid implementation details: that's
-        what the code is for, and I ignore whole tracts of useful
-        routines. This document assumes familiarity with C, and an
-        understanding of what the kernel is, and how it is used. It was
-        originally written for the 2.3 kernels, but nearly all of it
-        applies to 2.2 too; 2.0 is slightly different".
-
-    * Title: **Linux Kernel Locking HOWTO**
-
-      :Author: Various Talented People, and Rusty.
-      :Location: Documentation/DocBook/kernel-locking.tmpl
-      :Keywords: locks, locking, spinlock, semaphore, atomic, race
-        condition, bottom halves, tasklets, softirqs.
-      :Description: The title says it all: document describing the
-        locking system in the Linux Kernel either in uniprocessor or SMP
-        systems.
-      :Notes: "It was originally written for the later (>2.3.47) 2.3
-        kernels, but most of it applies to 2.2 too; 2.0 is slightly
-        different". Freely redistributable under the conditions of the GNU
-        General Public License.
-
 On-line docs
 ------------
 
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 4511eed0fabb..8d7ed0cbbf5f 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -197,13 +197,6 @@ ReSTマークアップを使ったドキュメントは Documentation/outputに
         make latexdocs
         make epubdocs
 
-現在、幾つかの DocBook形式で書かれたドキュメントは ReST形式に転換中で
-す。それらのドキュメントはDocumentation/DocBook ディレクトリに生成され、
-Postscript または man ページの形式を生成するには以下のようにします - ::
-
-        make psdocs
-        make mandocs
-
 カーネル開発者になるには
 ------------------------
 
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 2333697251dd..f06de9ca41a4 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -191,13 +191,6 @@ ReST 마크업을 사용하는 문서들은 Documentation/output 에 생성된
          make latexdocs
          make epubdocs
 
-현재, ReST 로의 변환이 진행중인, DocBook 으로 쓰인 문서들이 존재한다. 그런
-문서들은 Documentation/DocBook/ 디렉토리 안에 생성될 것이고 다음 커맨드를 통해
-Postscript 나 man page 로도 만들어질 수 있다::
-
-         make psdocs
-         make mandocs
-
 커널 개발자가 되는 것
 ---------------------
 
-- 
2.9.3
